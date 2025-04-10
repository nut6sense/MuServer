package services

import (
	"fmt"
	"maxion-zone4/models"
	"sync"
)

// MonsterTemplates เก็บข้อมูลมอนสเตอร์ที่โหลดจาก IGC_MonsterList.xml
var MonsterTemplates = make(map[int]*models.MonsterTemplate)

var MonsterManager = struct {
	mu       sync.RWMutex
	monsters map[int][]*models.Monster
}{
	monsters: make(map[int][]*models.Monster),
}

func AddMonster(zone int, m *models.Monster) {
	MonsterManager.mu.Lock()
	defer MonsterManager.mu.Unlock()
	MonsterManager.monsters[zone] = append(MonsterManager.monsters[zone], m)
}

func PrintMonsterSummary() {
	MonsterManager.mu.RLock()
	defer MonsterManager.mu.RUnlock()
	fmt.Println("=== Monster Summary ===")
	for zone, list := range MonsterManager.monsters {
		fmt.Printf("Zone %d → %d monsters\n", zone, len(list))
	}
}

func ListMonstersInZone(zone int) {
	MonsterManager.mu.RLock()
	defer MonsterManager.mu.RUnlock()
	monsters := MonsterManager.monsters[zone]
	fmt.Printf("\n-- Monsters in Zone %d --\n", zone)
	for _, m := range monsters {
		name := "Unknown"
		if t, ok := MonsterTemplates[m.Index]; ok {
			name = t.Name
		}
		fmt.Printf("ID: %s  Name: %-20s Pos: (%d,%d)  Target: (%d,%d)  Alive: %v\n",
			m.ID, name, m.Pos.X, m.Pos.Y, m.Target.X, m.Target.Y, m.Alive)
	}
}
