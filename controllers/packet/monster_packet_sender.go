package packet

import (
	"encoding/json"
	"fmt"
	"maxion-zone4/models"
	"maxion-zone4/packet"
	"net"
)

type MonsterPosition struct {
	ID string `json:"id"`
	X  int    `json:"x"`
	Y  int    `json:"y"`
}

type Packet struct {
	Type packet.PacketType `json:"type"`
	Data any               `json:"data"`
}

// SendMonsterPositionsToClient ส่งตำแหน่งของมอนสเตอร์ทั้งหมดในรูปแบบ JSON ไปยัง Client ผ่าน TCP
func SendMonsterPositionsToClient(conn net.Conn, monsters []*models.Monster) {
	positions := make([]MonsterPosition, 0, len(monsters))
	for _, m := range monsters {
		positions = append(positions, MonsterPosition{
			ID: m.ID,
			X:  m.Pos.X,
			Y:  m.Pos.Y,
		})
	}

	packet := Packet{
		Type: packet.PacketTypeMonsterMove,
		Data: positions,
	}

	data, err := json.Marshal(packet)
	if err != nil {
		fmt.Println("❌ Failed to marshal monster positions:", err)
		return
	}

	data = append(data, '\n') // เพื่อให้ client แยก packet ได้ง่าย
	_, err = conn.Write(data)
	if err != nil {
		fmt.Println("❌ Failed to send monster packet:", err)
	}
}
