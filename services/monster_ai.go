package services

import (
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"maxion-zone4/models"
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

					// 👁️ หา player ใกล้ที่สุดใน ViewRange
					nearest := findNearestPlayer(m, players)
					if nearest != nil && distance(m.Pos, nearest.Pos) <= template.ViewRange {
						m.Target = nearest.Pos

						// ⚔️ ถ้าอยู่ในระยะโจมตี
						if distance(m.Pos, nearest.Pos) <= template.AttackRange {
							simulateAttack(m, nearest)
							continue
						}

						// 🧭 หา path ไปหา player
						if len(m.Path) == 0 {
							path := models.FindPath(m.Pos, m.Target, tileMap)
							if len(path) > 1 {
								m.Path = path
							} else {
								log.Printf("⚠️ Monster %d path too short (%d), skipping", m.ID, len(path))
								m.Path = nil // reset เพื่อให้สุ่มรอบถัดไป
							}
						}
					}

					// 🔄 ถ้าไม่มีเป้าหมาย หรือ path เดินหมด → สุ่มเป้าหมายใหม่
					if len(m.Path) == 0 {
						tx, ty := getRandomWalkableWithinRange(tileMap, m.SpawnPos, template.MoveRange)
						newTarget := models.Vec2{X: tx, Y: ty}

						if m.Pos == newTarget {
							continue
						}

						m.Target = newTarget
						path := models.FindPath(m.Pos, m.Target, tileMap)
						if len(path) > 1 {
							m.Path = path
							// log.Printf("🚶 Monster %d walk to (%d,%d) full MoveRange: %d", m.ID, tx, ty, template.MoveRange)
						} else {
							log.Printf("⚠️ Monster %d path too short (%d), skipping", m.ID, len(path))
							m.Path = nil // reset เพื่อให้สุ่มรอบถัดไป
						}
					}

					// 👀 ตรวจผู้เล่นใกล้ zone เพื่อตัดสินใจ broadcast
					// const sightRange = 50
					// hasNearbyPlayer := false
					// for _, p := range players {
					// 	if distance(m.Pos, p.Pos) <= sightRange {
					// 		hasNearbyPlayer = true
					// 		break
					// 	}
					// }

					// หยุดเฉพาะตอนยังไม่มี path เท่านั้น
					if len(m.Path) == 0 && rand.Intn(15) == 0 {
						continue
					}

					now := time.Now()
					if len(m.Path) > 0 && now.Sub(m.LastMoveTime) >= m.MoveDelay {
						m.MoveStep(template)
						m.LastMoveTime = now

						movedMonsters[zoneID] = append(movedMonsters[zoneID], m)
					}
				}
			}
			// ✅ รวมส่ง movement ทีเดียวต่อ zone
			for zoneID, list := range movedMonsters {
				if len(list) > 0 {
					BroadcastMonsterGroupMoveToZone(zoneID, list)
				}
			}
		}
	}()
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
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
	if target.CurrentLife <= 0 {
		return
	}

	damage := rand.Intn(50) + 10
	target.CurrentLife -= damage
	if target.CurrentLife < 0 {
		// target.CurrentLife = 0
	}

	fmt.Printf("💢 Monster %d โจมตี Player %s → %d dmg (HP: %d)\n", m.ID, target.Name, damage, target.CurrentLife)

	attackPacket := map[string]any{
		"type": "MONSTER_ATTACK",
		"payload": map[string]any{
			"monsterId": m.ID,
			"targetId":  target.ID,
			"damage":    damage,
			"life":      target.CurrentLife,
		},
	}

	if data, err := json.Marshal(attackPacket); err == nil {
		SafeSend(target, data)
		log.Println("📡 MONSTER_ATTACK →", target.Name, "→", damage, "dmg")
	}

	if target.CurrentLife == 0 {
		// broadcastPlayerDeath(target)
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
	return center.X, center.Y
}
