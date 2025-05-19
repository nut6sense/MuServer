package services

import (
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/models"
	databaseModel "maxion-zone4/models/database"
	"maxion-zone4/models/message"
)

// Player แสดงข้อมูลของผู้เล่นขณะออนไลน์ (ไม่ใช่ struct DB)
type Player struct {
	ID          string       // ID เฉพาะ session นี้
	Name        string       // ชื่อตัวละคร
	ZoneID      int          // โซนปัจจุบัน / แผนที่
	Pos         models.Vec2  // ตำแหน่งในแผนที่
	CurrentLife int          // HP ปัจจุบัน
	MaxLife     int          // HP สูงสุด
	Send        func([]byte) `json:"-"` // ฟังก์ชันส่งข้อมูลกลับ client
}

// PlayerManager เก็บผู้เล่นทั้งหมดที่ออนไลน์ในขณะนี้
var PlayerManager = struct {
	Players map[string]*Player
}{
	Players: make(map[string]*Player),
}

// GetPlayersInZone คืนผู้เล่นทั้งหมดในโซนที่กำหนด
func GetPlayersInZone(zoneID int) []*Player {
	var list []*Player
	for _, p := range PlayerManager.Players {
		// if p.ZoneID == zoneID && p.CurrentLife > 0 {
		if p.ZoneID == zoneID {
			list = append(list, p)
		}
	}
	return list
}

func (p *Player) SendWithCode(code int, payload []byte) {
	packet := map[string]interface{}{
		"code": code,
		"body": string(payload),
	}
	data, err := json.Marshal(packet)
	if err != nil {
		fmt.Println("❌ Failed to marshal packet:", err)
		return
	}
	SafeSend(p, data)
}

type Sendable interface {
	SendPacket([]byte)
}

func (p *Player) SendPacket(data []byte) {
	if p.Send != nil {
		p.Send(data)
	}
}

func (p *PlayerConn) SendPacket(data []byte) {
	if p.Send != nil {
		p.Send(data)
	}
}

func SafeSend(p Sendable, data []byte) {
	defer func() {
		if r := recover(); r != nil {
			fmt.Println("❗ Recover from send panic:", r)
		}
	}()
	if p != nil {
		p.SendPacket(data)
	}
}

func PlayerRegis(username string, characterName string, zoneID int, data databaseModel.Character) {
	// ลงทะเบียนเมื่อ Player login เข้ามา
	player := &Player{
		ID:          username,
		Name:        characterName,
		ZoneID:      int(zoneID),
		Pos:         models.Vec2{X: int(data.MapPosX), Y: int(data.MapPosY)},
		CurrentLife: int(data.Life),
		MaxLife:     int(data.MaxLife),
		Send: func(data []byte) {
			err := SendUDP(message.SERVER_MESSAGE_MONSTER_MOVE, string(data))
			if err != nil {
				fmt.Printf("❌ MONSTER_MOVE error to %s: %v\n", username, err)
				// delete(utils.Accounts, username) // ลบ conn ที่ตาย
			}
		},
	}
	PlayerManager.Players[player.ID] = player
	jsonPlayer, _ := json.MarshalIndent(player, "", "  ")
	fmt.Println("Player Login (json):", string(jsonPlayer))
}

func RemovePlayer(username string) {
	player, ok := PlayerManager.Players[username]
	if !ok {
		fmt.Printf("⚠️ Player %s not found\n", username)
		return
	}
	delete(PlayerManager.Players, username)
	fmt.Printf("👋 Player %s (Zone %d) has logged out and was removed\n", player.Name, player.ZoneID)
}

func PlayerInZoneChecked(zoneID int) {
	var zoneNames = map[int]string{
		0: "Lorencia",
		1: "Dungeon",
		2: "Devias",
		3: "Noria",
	}

	zoneName, ok := zoneNames[zoneID]
	if !ok {
		zoneName = "Unknown"
	}

	if len(GetPlayersInZone(zoneID)) == 0 {
		log.Printf("Player 0")
	}

	fmt.Printf("👤 %d Players Online in 🗺️ Zone %d (%s)\n", len(GetPlayersInZone(zoneID)), zoneID, zoneName)
}
