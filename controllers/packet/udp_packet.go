package packet

import (
	"log"
	user_controller "maxion-zone4/controllers/user"
	"maxion-zone4/models/message"
	"strconv"
	"strings"

	skill "maxion-zone4/controllers/skill"
)

var udpPacketHandlers = map[int]func(string){
	message.USER_MESSAGE_1000:                 user_controller.LoginUserUDP,
	message.USER_MESSAGE_DISCONNECT_GO_SERVER: user_controller.DisconnectUser,
	message.USER_MESSAGE_GET_USE_SKILL:        skill.CharacterUseSkill,
	message.USER_MESSAGE_SET_USE_SKILL_RETURN: skill.CharacterUseSkill,
}

func ProcessUDP(packet string) {
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

	if handler, found := udpPacketHandlers[header]; found {
		handler(body)
	} else {
		log.Println("Unknown Packet Type")
	}
}
