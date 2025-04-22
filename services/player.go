
package services

import (
    "maxion-zone4/models"
)

// Player แสดงข้อมูลของผู้เล่นขณะออนไลน์ (ไม่ใช่ struct DB)
type Player struct {
    ID           string          // ID เฉพาะ session นี้
    Name         string          // ชื่อตัวละคร
    ZoneID       int             // โซนปัจจุบัน / แผนที่
    Pos          models.Vec2     // ตำแหน่งในแผนที่
    CurrentLife  int             // HP ปัจจุบัน
    MaxLife      int             // HP สูงสุด
    Send         func([]byte)    // ฟังก์ชันส่งข้อมูลกลับ client
}

// PlayerManager เก็บผู้เล่นทั้งหมดที่ออนไลน์ในขณะนี้
var PlayerManager = struct {
    Players map[string]*Player
}{
    Players: make(map[string]*Player),
}

// GetPlayersInZone คืนผู้เล่นทั้งหมดในโซนที่กำหนด
func GetPlayersInZone(zoneID int) []*Player {
    var list []*Player
    for _, p := range PlayerManager.Players {
        if p.ZoneID == zoneID && p.CurrentLife > 0 {
            list = append(list, p)
        }
    }
    return list
}
