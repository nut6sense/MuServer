package services

import (
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"sync"
)

func BroadcastMonsterToZone(zoneID int, m *models.Monster, template *models.MonsterTemplate) {
	if template == nil {
		fmt.Println("❌ Broadcast failed: template is nil for monster ID", m.ID, "Index", m.Index)
		return
	}

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
			SafeSend(player, data)
		}
	}
}

func BroadcastMonsterMoveToZone(zoneID int, m *models.Monster) {

	for _, player := range GetPlayersInZone(zoneID) {
		SendMonsterMoveToPlayer(player, m)
	}

	if len(GetPlayersInZone(zoneID)) == 0 {
		log.Printf("Player 0")
	}

	fmt.Printf("Broadcasting to %d players in zone %d\n", len(GetPlayersInZone(zoneID)), zoneID)
}

func SendMonsterMoveToPlayer(p *Player, m *models.Monster) {
	data := map[string]interface{}{
		"monsterId": m.ID,
		"x":         m.Pos.X,
		"y":         m.Pos.Y,
	}
	jsonData, _ := json.Marshal(data)
	p.SendWithCode(message.SERVER_MESSAGE_MONSTER_MOVE, jsonData)
}

// func SendMonsterPositionsToPlayer(player *Player, monsters []*models.Monster) {
// 	var list []map[string]interface{}
// 	for _, m := range monsters {
// 		list = append(list, map[string]interface{}{
// 			"id": m.ID,
// 			"x":  m.Pos.X,
// 			"y":  m.Pos.Y,
// 		})
// 	}
// 	data, _ := json.Marshal(list)

// 	player.SendWithCode(message.SERVER_MESSAGE_MONSTER_MOVE, data)
// }

// func SendMonsterCreate(player *services.Player, m *models.Monster, template *models.MonsterTemplate) {
// 	data, _ := json.Marshal(map[string]interface{}{
// 		"monsterId":   m.ID,
// 		"type":        m.Index,
// 		"x":           m.Pos.X,
// 		"y":           m.Pos.Y,
// 		"level":       template.Level,
// 		"name":        template.Name,
// 		"maxLife":     template.MaxLife,
// 		"currentLife": template.MaxLife,
// 	})

// 	player.SendWithCode(message.SERVER_MESSAGE_MONSTER_CREATE, data)
// }
