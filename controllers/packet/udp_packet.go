package packet

import (
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
	message.USER_MESSAGE_REGISTER_USER:        user_controller.LoginUserUDP,
}

type UDPClient struct {
	Addr      *net.UDPAddr
	NetworkID string
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
		if len(body) > 1 {
			networkID := strings.TrimSpace(body)
			RegisterUDPClient(addr, networkID)
		}
	}

	if handler, found := udpPacketHandlers[header]; found {
		handler(body)
	} else {
		log.Println("Unknown Packet Type")
	}
	var resHeader int
	if header == message.USER_MESSAGE_GET_USER_MOVE {
		resHeader = message.USER_MESSAGE_SET_USER_MOVE_RETURN
	} else if header == message.USER_MESSAGE_REGISTER_USER {
		resHeader = message.USER_MESSAGE_REGISTER_USER_RETURN
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

func RegisterUDPClient(addr *net.UDPAddr, networkID string) {
	clientKey := addr.String()

	UDPClientsMutex.Lock()
	defer UDPClientsMutex.Unlock()
	UDPClients[clientKey] = UDPClient{
		Addr:      addr,
		NetworkID: networkID,
	}

	log.Println("UDP Client registered:", networkID, "@", clientKey)
}

func RemoveUDPClient(clientID string) {
	UDPClientsMutex.Lock()
	defer UDPClientsMutex.Unlock()
	delete(UDPClients, clientID)
}
