package main

import (
	"fmt"
	"log"
	"maxion-zone4/config"
	"maxion-zone4/controllers"
	"maxion-zone4/controllers/character"
	"maxion-zone4/internal/logger"

	// inventory_controller "maxion-zone4/controllers/inventory"
	"maxion-zone4/models"
	"os"

	"maxion-zone4/services"
	"time"
)

func main() {
	// เรียก Init logger ก่อนใช้งาน
	logger.Init()

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

	// ⬇️ โหลด TileMap เข้า Redis หลัง Redis พร้อม
	if err := models.LoadTileMap(services.RedisClient); err != nil {
		msgError := fmt.Sprintf("Error loading tile map: %v", err)
		log.Println(msgError)
		logger.LogCritical(msgError)
	}

	// โหลด TileMap จาก Redis
	services.LoadTileMapsFromRedis()
	if err := services.LoadAllMonsterTemplates(); err != nil {
		msgError := fmt.Sprintf("Failed to load monster templates: %v", err)
		log.Println(msgError)
		logger.LogCritical(msgError)
	}

	// Load Spawn Monster
	spawnData, err := models.LoadMonsterSpawnFromXML()
	if err != nil {
		msgError := fmt.Sprintf("Failed to load monster spawn: %v", err)
		log.Println(msgError)
		logger.LogCritical(msgError)
	}

	services.SpawnMonstersFromSpawnData(spawnData)

	services.PrintMonsterSummary()
	for i := 0; i < 4; i++ {
		services.ListMonstersInZone(i)
	}
	services.StartMonsterAI()
	services.StartCharacterPositionSyncLoop()

	fmt.Println("Servers are running...")

	go func() {
		ticker := time.NewTicker(5 * time.Second)
		for range ticker.C {
			for i := 0; i < 4; i++ {
				services.PlayerInZoneChecked(i)
			}
		}
	}()

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
