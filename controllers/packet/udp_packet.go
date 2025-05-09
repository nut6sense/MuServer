package packet

import (
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/config"
	user_controller "maxion-zone4/controllers/user"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"net"
	"strconv"
	"strings"
	"sync"

	skill "maxion-zone4/controllers/skill"
)

var udpPacketHandlers = map[int]func(string){
	message.USER_MESSAGE_1000:                 user_controller.LoginUserUDP,
	message.USER_MESSAGE_DISCONNECT_GO_SERVER: user_controller.DisconnectUser,
	message.USER_MESSAGE_GET_USE_SKILL:        skill.CharacterUseSkill,
	message.USER_MESSAGE_SET_USE_SKILL_RETURN: skill.CharacterUseSkill,
	message.USER_MESSAGE_GET_USER_MOVE:        user_controller.MoveUserUDP,
	message.USER_MESSAGE_GET_USER_ATTACK:      user_controller.AttackUserUDP,
	message.USER_MESSAGE_REGISTER_USER:        user_controller.LoginUserUDP,
	message.USER_MESSAGE_LOGOUT_USER:          user_controller.LogoutUserUDP,
	message.SERVER_MESSAGE_MONSTER_MOVE:       user_controller.MoveMonsterUDP,
}

type UDPClient struct {
	Addr      *net.UDPAddr
	NetworkID string
	Position  Coordinates
}

type Coordinates struct {
	X int `json:"x"`
	Y int `json:"y"`
}

var UDPClients = make(map[string]UDPClient) // key ยังคงเป็น addr.String() (หรือจะเปลี่ยนเป็น networkID ก็ได้)
var UDPClientsMutex = sync.RWMutex{}

func ProcessUDP(packet string, addr *net.UDPAddr) {

	header, err := strconv.Atoi(strings.Split(packet, "|")[0])
	if err != nil {
		log.Println("UDP Invalid Header from packet: ", err)
		return
	}

	body := strings.Split(packet, "|")[1]
	if body == "" {
		log.Println("Invalid Body from packet: ", err)
		return
	}

	// ✅ Register client address
	if header == message.USER_MESSAGE_REGISTER_USER {

		var data models.RegisterUserDTO
		err := json.Unmarshal([]byte(body), &data)
		if err != nil {
			fmt.Println("❌ JSON parsing failed in ProcessUDP:", err)
			return
		}

		if len(body) > 1 {
			//networkID := strings.TrimSpace(data.ID)
			RegisterUDPClient(addr, body)
			SendExistingPlayersToNewClient(addr)
		}
	}
	// 🔍 ตรวจสอบว่าเป็น Header Logout หรือไม่
	if header == message.USER_MESSAGE_LOGOUT_USER {
		// ✅ ลบจาก UDPClients
		networkID := strings.TrimSpace(body)
		RemoveUDPClient(networkID)
	}

	if handler, found := udpPacketHandlers[header]; found {
		handler(body)
	} else {
		log.Println("Unknown Packet Type")
	}
	var resHeader int
	if header == message.USER_MESSAGE_GET_USER_MOVE {
		var moveData models.MoveDataDTO
		err := json.Unmarshal([]byte(body), &moveData)
		if err != nil {
			fmt.Println("❌ JSON parsing failed:", err)
			return
		}
		UpdateUDPClientPosition(addr, moveData.Position.X, moveData.Position.Y)
		resHeader = message.USER_MESSAGE_SET_USER_MOVE_RETURN
	} else if header == message.USER_MESSAGE_GET_USER_ATTACK {
		resHeader = message.USER_MESSAGE_SET_USER_ATTACK_RETURN
	} else if header == message.USER_MESSAGE_REGISTER_USER {
		resHeader = message.USER_MESSAGE_REGISTER_USER_RETURN
	} else if header == message.USER_MESSAGE_LOGOUT_USER {
		resHeader = message.USER_MESSAGE_LOGOUT_USER_RETURN
	}

	BroadcastUDP(resHeader, body, addr)
}

func BroadcastUDP(header int, body string, excludeAddr *net.UDPAddr) {
	packet := strconv.Itoa(header) + "|" + body
	response, err := models.EncryptMessage(packet)
	if err != nil {
		log.Println("Error encrypting UDP packet:", err)
		return
	}

	UDPClientsMutex.RLock()
	defer UDPClientsMutex.RUnlock()

	for _, client := range UDPClients {
		// ข้าม client ตัวเอง (ผู้ส่ง)
		if excludeAddr != nil && client.Addr.String() == excludeAddr.String() {
			continue
		}

		_, err := config.ConnUDP.WriteToUDP([]byte(response), client.Addr)
		if err != nil {
			log.Printf("❌ Failed to send to [%s] (%s): %v\n", client.NetworkID, client.Addr, err)
		} else {
			log.Printf("✅ Broadcasted to [%s] (%s)\n", client.NetworkID, client.Addr)
		}
	}
}

func SendExistingPlayersToNewClient(newClientAddr *net.UDPAddr) {
	UDPClientsMutex.RLock()
	defer UDPClientsMutex.RUnlock()

	for _, client := range UDPClients {
		if client.Addr.String() == newClientAddr.String() {
			continue
		}

		// ✅ สร้าง RegisterUserDTO
		userDTO := models.RegisterUserDTO{
			ID: client.NetworkID,
			Coord: models.CoordDTO{
				X: client.Position.X,
				Y: client.Position.Y,
			},
		}

		// ✅ Serialize เป็น JSON
		body, err := json.Marshal(userDTO)
		if err != nil {
			log.Println("❌ JSON Marshalling failed:", err)
			continue
		}

		// ✅ สร้าง Packet ใหม่
		packet := strconv.Itoa(message.USER_MESSAGE_REGISTER_USER_RETURN) + "|" + string(body)

		response, err := models.EncryptMessage(packet)
		if err != nil {
			log.Println("Error encrypting user data for new client:", err)
			continue
		}

		_, err = config.ConnUDP.WriteToUDP([]byte(response), newClientAddr)
		if err != nil {
			log.Printf("❌ Failed to send existing client to new client: %v\n", err)
		} else {
			log.Printf("✅ Sent existing client [%s] to new client (%s)\n", client.NetworkID, newClientAddr)
		}
	}
}

func RegisterUDPClient(addr *net.UDPAddr, body string) {
	clientKey := addr.String()

	UDPClientsMutex.Lock()
	defer UDPClientsMutex.Unlock()

	var data models.RegisterUserDTO
	err := json.Unmarshal([]byte(body), &data)
	if err != nil {
		fmt.Println("❌ JSON parsing failed in ProcessUDP:", err)
		return
	}

	// Check if the client is already registered with the same networkID
	if existingClient, exists := UDPClients[clientKey]; exists {
		if existingClient.NetworkID == data.ID {
			log.Println("UDP Client already registered:", data.ID, "@", clientKey)
			return
		}
	}

	// ✅ เพิ่มตำแหน่งที่ส่งมาใน UDPClient
	UDPClients[clientKey] = UDPClient{
		Addr:      addr,
		NetworkID: data.ID,
		Position: Coordinates{
			X: data.Coord.X,
			Y: data.Coord.Y,
		},
	}

	log.Printf("✅ UDP Client registered: %s @ %s (Position: %d, %d)", data.ID, clientKey, data.Coord.X, data.Coord.Y)
}

func UpdateUDPClientPosition(addr *net.UDPAddr, x int, y int) {
	clientKey := addr.String()

	UDPClientsMutex.Lock()
	defer UDPClientsMutex.Unlock()

	if client, exists := UDPClients[clientKey]; exists {
		client.Position.X = x
		client.Position.Y = y
		UDPClients[clientKey] = client

		log.Printf("✅ Updated position for %s to (%d, %d)", client.NetworkID, x, y)
	} else {
		log.Printf("⚠️ Client %s not found to update position", clientKey)
	}
}

func RemoveUDPClient(body string) {

	var data models.RegisterUserDTO
	err := json.Unmarshal([]byte(body), &data)
	if err != nil {
		fmt.Println("❌ JSON parsing failed in ProcessUDP:", err)
		return
	}

	UDPClientsMutex.Lock()
	defer UDPClientsMutex.Unlock()

	// ✅ Loop ผ่าน UDPClients ทั้งหมดเพื่อตรวจสอบ ID
	for key, client := range UDPClients {
		if client.NetworkID == data.ID {
			// ถ้าเจอให้ลบออกจาก Map
			delete(UDPClients, key)
			log.Printf("✅ Removed UDPClient with ID: %s (Key: %s)", data.ID, key)
			return
		}
	}

	log.Printf("⚠️ No UDPClient found with ID: %s", data.ID)
	//delete(UDPClients, data.ID)
}
