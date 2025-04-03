package main

import (
	"fmt"
	"log"
	"maxion-zone4/config"
	"maxion-zone4/controllers"
	"maxion-zone4/controllers/character"
	"os"

	"maxion-zone4/services"
	"time"
)

func main() {
	printChannelInfo()

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

	// go inventory_controller.StartInventory()

	fmt.Println("Servers are running...")

	select {}
}

func printChannelInfo() {
	name := os.Getenv("CHANNEL_NAME")
	tcp := os.Getenv("TCP_PORT")
	udp := os.Getenv("UDP_PORT")
	port := os.Getenv("CHANNEL_PORT")

	fmt.Println("================================")
	fmt.Printf("🟢 %s is starting\n", name)
	fmt.Printf("🔌 TCP_PORT: %s\n", tcp)
	fmt.Printf("📡 UDP_PORT: %s\n", udp)
	fmt.Printf("🎮 GAME_PORT: %s\n", port)
	fmt.Println("================================")
}
