package services

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"time"
)

// เริ่มระบบ AI สำหรับ Monster เดิน, ไล่ผู้เล่น, โจมตี, และส่ง Packet
func StartMonsterAI() {
	ticker := time.NewTicker(500 * time.Millisecond)
	go func() {
		for range ticker.C {
			movedMonsters := make(map[int][]*models.Monster) // zoneID → []*Monster

			for zoneID, monsters := range MonsterManager.monsters {
				tileMap := TileMapData[zoneID]
				if tileMap == nil {
					continue
				}

				players := GetPlayersInZone(zoneID)

				for _, m := range monsters {
					if !m.Alive {
						continue
					}

					template := MonsterTemplates[m.Index]
					if template == nil {
						continue
					}

					now := time.Now()

					// 👁️ หา player ใกล้ที่สุดใน ViewRange
					nearest := findNearestPlayer(m, players)
					if nearest != nil && distance(m.Pos, nearest.Pos) <= template.ViewRange {
						// ✅ เปลี่ยน target เฉพาะเมื่อระยะเปลี่ยน
						if m.Target != nearest.Pos || len(m.Path) == 0 {
							m.Target = nearest.Pos
							m.Path = nil
						}

						// ⚔️ แยก logic โจมตีออกจากการเดิน
						if distance(m.Pos, nearest.Pos) <= template.AttackRange {
							cooldown := attackSpeedToCooldownMs(template.AttackSpeed)
							if time.Since(m.LastAttackTime) >= cooldown {
								simulateAttack(m, nearest)
								m.LastAttackTime = now

								// ❗ หยุดเดินเพื่อให้ตีต่อเนื่อง
								m.Path = nil
								continue
							}
						}
					}

					// 🧭 หา path ไปหา target (player หรือเป้าสุ่ม)
					if len(m.Path) == 0 && m.Target != (models.Vec2{}) {
						path := models.FindPath(m.Pos, m.Target, tileMap)
						if len(path) > 1 {
							m.Path = path
						} else {
							m.Path = nil
							m.Target = models.Vec2{}
						}
					}

					// 🔄 fallback → สุ่มเป้าหมายเมื่อไม่มี path และไม่มีเป้าหมาย
					if len(m.Path) == 0 && m.Target == (models.Vec2{}) {
						if rand.Intn(100) < 10 {
							continue // นิ่งบางรอบ
						}

						tx, ty := getRandomWalkableWithinRange(tileMap, m.SpawnPos, template.MoveRange)
						if tx >= 0 && ty >= 0 {
							newTarget := models.Vec2{X: tx, Y: ty}
							if newTarget != m.Pos {
								m.Target = newTarget
								path := models.FindPath(m.Pos, m.Target, tileMap)
								if len(path) > 1 {
									m.Path = path
								} else {
									m.Path = nil
									m.Target = models.Vec2{}
								}
							}
						}
					}

					// 👣 เดินไปตาม path
					if len(m.Path) > 0 && now.Sub(m.LastMoveTime) >= m.MoveDelay {
						m.MoveStep(template)
						m.LastMoveTime = now
						movedMonsters[zoneID] = append(movedMonsters[zoneID], m)
					}
				}
			}

			// ✅ รวมส่ง movement ต่อ zone
			for zoneID, list := range movedMonsters {
				if len(list) > 0 {
					BroadcastMonsterGroupMoveToZone(zoneID, list)
				}
			}
		}
	}()
}

// สุ่มตำแหน่งที่สามารถเดินได้ในแผนที่
func getRandomWalkable(tileMap [][]models.Tile) (int, int) {
	for i := 0; i < 100; i++ {
		x := rand.Intn(256)
		y := rand.Intn(256)
		if tileMap[y][x].Walkable {
			return x, y
		}
	}
	return 100, 100
}

// คำนวณระยะห่างแบบ Manhattan
func distance(a, b models.Vec2) int {
	dx := a.X - b.X
	dy := a.Y - b.Y
	if dx < 0 {
		dx = -dx
	}
	if dy < 0 {
		dy = -dy
	}
	return dx + dy
}

// หาผู้เล่นที่อยู่ใกล้มอนสเตอร์ที่สุด
func findNearestPlayer(m *models.Monster, players []*Player) *Player {
	template := MonsterTemplates[m.Index]
	if template == nil {
		return nil // ป้องกันไม่ให้ nil panic
	}

	var nearest *Player
	viewRange := template.ViewRange

	for _, p := range players {
		d := distance(m.Pos, p.Pos)
		if d <= viewRange {
			if nearest == nil || d < distance(m.Pos, nearest.Pos) {
				nearest = p
			}
		}
	}
	return nearest
}

// โจมตีผู้เล่น → ลด HP → ส่ง Packet → ถ้าตายให้ broadcast
func simulateAttack(m *models.Monster, target *Player) {
	target.CurrentLife = target.MaxLife

	if target.CurrentLife <= 0 {
		return
	}

	// สุ่มความเสียหาย
	damage := rand.Intn(50) + 10
	target.CurrentLife -= damage

	// ❗ ป้องกัน HP ติดลบ
	if target.CurrentLife < 0 {
		target.CurrentLife = 0
	}

	// log การโจมตี
	fmt.Printf("💢 Monster %d โจมตี Player %s → %d dmg (HP: %d)\n", m.ID, target.Name, damage, target.CurrentLife)

	// สร้างแพ็กเกจการโจมตี
	attackPacket := map[string]any{
		"type": "MONSTER_ATTACK",
		"payload": map[string]any{
			"monsterId": m.ID,
			"targetId":  target.ID,
			"damage":    damage,
			"life":      target.CurrentLife,
		},
	}

	// ส่งแพ็กเกจไปยัง player ที่โดน
	if data, err := json.Marshal(attackPacket); err == nil {
		SendUDP(message.SERVER_MESSAGE_MONSTER_ATTACK, string(data))
		log.Println("📡 MONSTER_ATTACK →", target.Name, "→", damage, "dmg")
	}

	// ❗ แจ้งว่า player ตาย ถ้า HP หมด
	if target.CurrentLife == 0 {
		log.Printf("💀 Player %s ตายจาก Monster %d", target.Name, m.ID)
		// broadcastPlayerDeath(target)

		// Optional: Mark ว่า player ตาย
		// target.Alive = false
	}
}

// แจ้งว่าผู้เล่นตายแล้ว
func broadcastPlayerDeath(p *Player) {
	deathPacket := map[string]interface{}{
		"type": "PLAYER_DIE",
		"payload": map[string]interface{}{
			"playerId": p.ID,
			"name":     p.Name,
		},
	}

	if data, err := json.Marshal(deathPacket); err == nil {
		BroadcastToZone(p.ZoneID, data)
		log.Println("📡 PLAYER_DIE → zone", p.ZoneID, ":", p.Name)
	}
}

// สุ่มเดินในระยะ MoveRange
func getRandomWalkableWithinRange(tileMap [][]models.Tile, center models.Vec2, moveRange int) (int, int) {
	for i := 0; i < 100; i++ {
		dx := rand.Intn(moveRange*2+1) - moveRange
		dy := rand.Intn(moveRange*2+1) - moveRange
		nx := center.X + dx
		ny := center.Y + dy

		if ny >= 0 && ny < len(tileMap) && nx >= 0 && nx < len(tileMap[0]) {
			// ✅ ป้องกันคืนตำแหน่งเดิม
			if tileMap[ny][nx].Walkable && (nx != center.X || ny != center.Y) {
				return nx, ny
			}
		}
	}
	// fallback ถ้าหาไม่ได้
	// return center.X, center.Y
	return -1, -1
}

func attackSpeedToCooldownMs(atkSpeed int) time.Duration {
	if atkSpeed <= 0 {
		return 1500 * time.Millisecond // fallback default
	}
	return time.Duration(100000/(15*atkSpeed)) * time.Millisecond
}
