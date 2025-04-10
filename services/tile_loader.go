package services

import (
	"context"
	"fmt"
	"maxion-zone4/models"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"sync"
)

// TileMapData เก็บ tile map ทั้งหมดจาก Redis สำหรับใช้กับ Monster
var (
	TileMapData      map[int][][]models.Tile
	tileMapDataMutex sync.RWMutex
)

// LoadTileMapsFromRedis โหลดแผนที่ทุก zone ที่ต้องใช้จาก Redis เข้าหน่วยความจำ
func LoadTileMapsFromRedis() error {
	ctx := context.Background()
	tileMapDataMutex.Lock()
	TileMapData = make(map[int][][]models.Tile)
	tileMapDataMutex.Unlock()

	mapPath := "data/maps"
	files, err := os.ReadDir(mapPath)
	if err != nil {
		return fmt.Errorf("failed to read map directory: %w", err)
	}

	for _, file := range files {
		if file.IsDir() || !strings.HasSuffix(file.Name(), ".att") {
			continue
		}

		zoneID, err := extractZoneIDFromFilename(file.Name())
		if err != nil {
			fmt.Println("❗ Skip invalid map filename:", file.Name())
			continue
		}

		tileMap, err := models.LoadTileMapFromRedis(RedisClient, ctx, zoneID)
		if err != nil {
			fmt.Println("Failed to load zone", zoneID, err)
			continue
		}

		tileMapDataMutex.Lock()
		TileMapData[zoneID] = tileMap
		tileMapDataMutex.Unlock()

		fmt.Println("✅ Loaded TileMap for zone", zoneID)
	}
	return nil
}

// extractZoneIDFromFilename แยกเลขโซนจากชื่อไฟล์ เช่น 00_Lorencia.att -> 0
func extractZoneIDFromFilename(filename string) (int, error) {
	base := filepath.Base(filename)
	parts := strings.SplitN(base, "_", 2)
	if len(parts) < 1 {
		return -1, fmt.Errorf("invalid filename format")
	}
	return strconv.Atoi(parts[0])
}
