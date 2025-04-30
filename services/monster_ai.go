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
			for zoneID, monsters := range MonsterManager.monsters {
				tileMap := TileMapData[zoneID]
				players := GetPlayersInZone(zoneID) // ดึงผู้เล่นในโซนเดียวกัน

				for _, m := range monsters {
					if !m.Alive {
						continue
					}

					template := MonsterTemplates[m.Index]
					if template == nil {
						continue // ถ้าไม่มี template ไม่ทำอะไร
					}

					nearest := findNearestPlayer(m, players)
					if nearest != nil {
						// เช็คว่ามองเห็น Player ไหม
						if distance(m.Pos, nearest.Pos) <= template.ViewRange {
							m.Target = nearest.Pos

							// ถ้าอยู่ใน AttackRange แล้ว → ไม่ต้องเดิน
							if distance(m.Pos, nearest.Pos) <= template.AttackRange {
								simulateAttack(m, nearest)
								continue
							}

							// ถ้าไกลเกิน AttackRange → เดินเข้าไป
							if len(m.Path) == 0 {
								m.Path = models.FindPath(m.Pos, m.Target, tileMap)
							}
						}
					} else if len(m.Path) == 0 {
						// เดินสุ่มใน MoveRange
						tx, ty := getRandomWalkableWithinRange(tileMap, m.SpawnPos, template.MoveRange)
						m.Target = models.Vec2{X: tx, Y: ty}
						m.Path = models.FindPath(m.Pos, m.Target, tileMap)
					}

					// ถ้าเจอเป้าหมาย → เดินตาม
					// if nearest != nil {
					// 	m.Target = nearest.Pos
					// 	m.Path = models.FindPath(m.Pos, m.Target, tileMap)
					// } else if len(m.Path) == 0 {
					// ถ้าไม่มีเป้าหมาย → เดินสุ่ม
					tx, ty := getRandomWalkable(tileMap)
					m.Target = models.Vec2{X: tx, Y: ty}
					m.Path = models.FindPath(m.Pos, m.Target, tileMap)
					//}

					const sightRange = 20

					// เช็คว่ามี Player ที่อยู่ใกล้ monster ตัวนี้
					hasNearbyPlayer := false
					for _, p := range players {
						if distance(m.Pos, p.Pos) <= sightRange {
							hasNearbyPlayer = true
							break
						}
					}

					// ถ้ามี path → เดิน 1 ก้าว
					if len(m.Path) > 0 {
						m.MoveStep()
						if hasNearbyPlayer {
							BroadcastMonsterMoveToZone(zoneID, m)
							log.Println("📡 MONSTER_MOVE → zone", zoneID, "→", m.ID, "→", m.Pos.X, m.Pos.Y)
						}
					}
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
	if target.CurrentLife <= 0 {
		return
	}

	damage := rand.Intn(50) + 10
	target.CurrentLife -= damage
	if target.CurrentLife < 0 {
		target.CurrentLife = 0
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
		broadcastPlayerDeath(target)
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

		if nx >= 0 && nx < len(tileMap[0]) && ny >= 0 && ny < len(tileMap) {
			if tileMap[ny][nx].Walkable {
				return nx, ny
			}
		}
	}
	// ถ้าไม่เจอเลย return spawn จุดเดิม
	return center.X, center.Y
}
