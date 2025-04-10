
package services

import (
    "fmt"
    "math/rand"
    "maxion-zone4/models"
    "time"
)

// SpawnMonstersFromSpawnData สร้าง Monster จากข้อมูล spawn maps และใส่ลงใน zone
func SpawnMonstersFromSpawnData(spawnMaps []models.MonsterSpawnMapXML) {
    rand.Seed(time.Now().UnixNano())

    for _, zone := range spawnMaps {
        tileMap := TileMapData[zone.Number]
        if tileMap == nil {
            fmt.Println("❌ No TileMap for zone", zone.Number)
            continue
        }

        for _, spot := range zone.Spots {
            for _, entry := range spot.Spawns {
                template := MonsterTemplates[entry.Index]
                for i := 0; i < entry.Count; i++ {
                    pos := getRandomWalkableInArea(tileMap, entry.StartX, entry.StartY, entry.EndX, entry.EndY)
                    target := getRandomWalkableInArea(tileMap, entry.StartX, entry.StartY, entry.EndX, entry.EndY)

                    m := models.NewMonster(pos, target)
                    m.Index = entry.Index
                    AddMonster(zone.Number, m)
                    BroadcastMonsterToZone(zone.Number, m, template)
                }
            }
        }
        fmt.Println("✅ Spawned monsters for zone", zone.Number)
    }
}

func getRandomWalkableInArea(tileMap [][]models.Tile, sx, sy, ex, ey int) models.Vec2 {
    for {
        x := rand.Intn(ex-sx+1) + sx
        y := rand.Intn(ey-sy+1) + sy
        if y >= 0 && y < 256 && x >= 0 && x < 256 && tileMap[y][x].Walkable {
            return models.Vec2{X: x, Y: y}
        }
    }
}
