package services

import (
	"encoding/json"
	"fmt"
	"maxion-zone4/models"
	"sync"
)

func BroadcastMonsterToZone(zoneID int, m *models.Monster, template *models.MonsterTemplate) {
	packet := struct {
		Type    string                     `json:"type"`
		Payload models.MonsterCreatePacket `json:"payload"`
	}{
		Type: "MONSTER_CREATE",
		Payload: models.MonsterCreatePacket{
			MonsterId:          m.ID,
			Type:               m.Index,
			X:                  byte(m.Pos.X),
			Y:                  byte(m.Pos.Y),
			TargetX:            byte(m.Target.X),
			TargetY:            byte(m.Target.Y),
			Direction:          0, // เพิ่มระบบหมุนได้ภายหลัง
			Level:              template.Level,
			MaxLife:            template.MaxLife,
			CurrentLife:        template.MaxLife,
			PentagramAttribute: byte(template.Attribute),
			Name:               template.Name,
		},
	}

	jsonData, err := json.Marshal(packet)
	if err != nil {
		fmt.Println("❌ Failed to marshal monster packet:", err)
		return
	}

	BroadcastToZone(zoneID, jsonData)
}

type PlayerConn struct {
	ZoneID int
	Send   func(data []byte)
}

var ConnectedPlayers = struct {
	sync.RWMutex
	players map[string]*PlayerConn
}{
	players: make(map[string]*PlayerConn),
}

// BroadcastToZone ส่ง packet ไปให้ทุก player ที่อยู่ใน zone นั้น
func BroadcastToZone(zoneID int, data []byte) {
	ConnectedPlayers.RLock()
	defer ConnectedPlayers.RUnlock()

	for _, player := range ConnectedPlayers.players {
		if player.ZoneID == zoneID {
			player.Send(data)
		}
	}
}
