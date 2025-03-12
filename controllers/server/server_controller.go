package server_controller

import (
	"encoding/json"
	"log"
	databaseModel "maxion-zone4/models/database"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"reflect"
)

func GetServerList(Body string, username string) {
	var data []databaseModel.Server
	result := services.GameDB.Table("Servers").Select("ServerCode, Name, ButtonPos, InfoText, Visible").Where("Visible = 1").Find(&data)
	if result.Error != nil {
		log.Println("Database error:", result.Error)
		services.SendTCPUser(message.SERVER_MESSAGE_GET_SERVER_LIST_ERROR, "Get Server List Error", username)
	} else {
		log.Printf("Query Result: %+v\n", reflect.ValueOf(data))
		jsonData, err := json.Marshal(data)
		if err != nil {
			log.Println("Error converting to JSON:", err)
		}

		services.SendTCPUser(message.SERVER_MESSAGE_SET_SERVER_LIST, string(jsonData), username)
	}
}

func GetChanelList(Body string, username string) {
	var data []databaseModel.Chanel
	var ServerCode = Body
	result := services.GameDB.Table("Chanel").Select("ChanelCode, ServerCode, Name, Visible").Where("Visible = 1 AND ServerCode = ?", ServerCode).Find(&data)
	if result.Error != nil {
		log.Println("Database error:", result.Error)
		services.SendTCPUser(message.SERVER_MESSAGE_GET_CHANEL_LIST_ERROR, "Get Chanel List Error", username)
	} else {
		log.Printf("Query Result: %+v\n", reflect.ValueOf(data))
		jsonData, err := json.Marshal(data)
		if err != nil {
			log.Println("Error converting to JSON:", err)
		}

		services.SendTCPUser(message.SERVER_MESSAGE_SET_CHANEL_LIST, string(jsonData), username)
	}
}

func SelectChanel(Body string, username string) {

	log.Println("Select Chanel : ", Body)

	// var data []databaseModel.Chanel
	// result := services.GameDB.Table("Servers").Select("ChanelCode, ServerCode, Name").Where("Visible = 1").Find(&data)
	// if result.Error != nil {
	// 	log.Println("Database error:", result.Error)
	// 	services.SendTCPUser(message.SERVER_MESSAGE_GET_CHANEL_LIST_ERROR, "Get Chanel List Error", username)
	// } else {
	// 	log.Printf("Query Result: %+v\n", reflect.ValueOf(data))
	// 	jsonData, err := json.Marshal(data)
	// 	if err != nil {
	// 		log.Println("Error converting to JSON:", err)
	// 	}

	// 	services.SendTCPUser(message.SERVER_MESSAGE_SET_CHANEL_LIST, string(jsonData), username)
	// }
}
