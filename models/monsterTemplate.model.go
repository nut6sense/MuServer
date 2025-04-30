package models

import (
	"encoding/xml"
	"fmt"
	"os"
)

// MonsterTemplate ครอบคลุมทุกข้อมูลที่โหลดจาก IGC_MonsterList.xml

type MonsterTemplate struct {
	Index         int    `xml:"Index,attr"`         // รหัสไอดีของมอนสเตอร์ (เชื่อมกับระบบ Spawn)
	Name          string `xml:"Name,attr"`          // ชื่อมอนสเตอร์
	Level         int    `xml:"Level,attr"`         // เลเวลของมอนสเตอร์ (มีผลต่อ EXP และสเกลความเก่ง)
	MaxLife       int    `xml:"Life,attr"`          // พลังชีวิตสูงสุด (HP) ของมอนสเตอร์
	DamageMin     int    `xml:"DamageMin,attr"`     // ค่าดาเมจต่ำสุดที่มอนสเตอร์สามารถทำได้
	DamageMax     int    `xml:"DamageMax,attr"`     // ค่าดาเมจสูงสุดที่มอนสเตอร์สามารถทำได้
	Defense       int    `xml:"Defense,attr"`       // ค่าป้องกันกายภาพ ลดดาเมจที่ได้รับจากการโจมตีปกติ
	MagicDefense  int    `xml:"MagicDefense,attr"`  // ค่าป้องกันเวทย์มนต์ ลดดาเมจที่ได้รับจากการโจมตีเวทย์
	MoveRange     int    `xml:"MoveRange,attr"`     // ระยะทางสูงสุดที่มอนสเตอร์สามารถเดินออกจากจุดเกิดได้
	AttackType    int    `xml:"AttackType,attr"`    // ประเภทการโจมตี: 0 = กายภาพ, 1 = เวทย์, 2 = ยิงธนู เป็นต้น
	AttackRange   int    `xml:"AttackRange,attr"`   // ระยะการโจมตี: 1 = ใกล้, มากกว่า 1 = ระยะไกล
	ViewRange     int    `xml:"ViewRange,attr"`     // ระยะการตรวจจับเป้าหมาย (เช่น ผู้เล่นที่เข้ามาใกล้)
	MoveSpeed     int    `xml:"MoveSpeed,attr"`     // ความเร็วในการเคลื่อนที่ (มิลลิวินาทีต่อ 1 ช่อง tile)
	AttackSpeed   int    `xml:"AttackSpeed,attr"`   // ความเร็วในการโจมตี (มิลลิวินาทีต่อการโจมตีหนึ่งครั้ง)
	RegenTime     int    `xml:"RegenTime,attr"`     // เวลาที่ใช้ฟื้นคืนชีพหลังจากมอนสเตอร์ตาย (วินาที)
	Attribute     int    `xml:"Attribute,attr"`     // ธาตุประจำตัวของมอนสเตอร์ (0 = None, 1 = Fire, 2 = Water, ฯลฯ)
	ItemDropRate  int    `xml:"ItemDropRate,attr"`  // อัตราการดรอปไอเท็ม (ยิ่งสูงยิ่งมีโอกาสดรอปมากขึ้น)
	MoneyDropRate int    `xml:"MoneyDropRate,attr"` // อัตราการดรอปเงิน (Zen) เมื่อมอนสเตอร์ตาย
	MaxItemLevel  int    `xml:"MaxItemLevel,attr"`  // เลเวลสูงสุดของไอเท็มที่มอนสเตอร์สามารถดรอปได้
	IndexStr      string `xml:"IndexStr,attr"`      // (เพิ่มเติมเอง) เก็บ Index แบบ string (ใช้ตอน parse XML ที่บางไฟล์อาจเป็น string)
}

type monsterListXML struct {
	Monsters []MonsterTemplate `xml:"Monster"`
}

func LoadMonsterTemplates(path string) map[int]*MonsterTemplate {
	file, err := os.Open(path)
	if err != nil {
		fmt.Println("❌ Failed to open MonsterList XML:", err)
		return nil
	}
	defer file.Close()

	var parsed monsterListXML
	if err := xml.NewDecoder(file).Decode(&parsed); err != nil {
		fmt.Println("❌ Failed to parse MonsterList XML:", err)
		return nil
	}

	templates := make(map[int]*MonsterTemplate)
	for i := range parsed.Monsters {
		t := &parsed.Monsters[i]
		templates[t.Index] = t
	}
	fmt.Println("✅ Loaded", len(templates), "monster templates from", path)
	return templates
}
