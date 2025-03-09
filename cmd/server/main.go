package main

import (
	"log"
	"maxion-zone4/config"
	"maxion-zone4/controllers"
	"maxion-zone4/controllers/character"
	"maxion-zone4/services"
	"time"
)

func main() {
	loc, err := time.LoadLocation("Asia/Bangkok")
	if err != nil {
		log.Println("Error loading location:", err)
	}
	time.Local = loc
	config.LoadConfig()

	go services.StartTCPListener()
	go controllers.StartTCPServer()
	go controllers.StartUDPServer()

	services.DBGameConnect()
	services.DBGameInventoryConnect()
	// services.DBGameRecordConnect() // Nut Close
	services.InitializeRedisDatabases()

	// Load after dbgame connect
	go character.ScheduleResetStamina()

	// matching.StartMatchQueue([]matching.MatchRequest{
	// 	{Character: "test", Rank: 100},
	// 	{Character: "test1", Rank: 100},
	// 	{Character: "test2", Rank: 100},
	// 	{Character: "test3", Rank: 100},
	// })
	// go matching.StartMatchQueue("Ranking_51")
	// time.Sleep(5 * time.Second)
	// go matching.StartMatchQueue("Ranking_52")
	// time.Sleep(5 * time.Second)
	// go matching.StartMatchQueue("Ranking_53")
	// time.Sleep(5 * time.Second)
	// go matching.StartMatchQueue("Ranking_54")
	// time.Sleep(5 * time.Second)
	// go matching.StartMatchQueue("Ranking_55")

	log.Println("Servers are running...")

	select {}
}
