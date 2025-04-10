package models

import (
	"encoding/xml"
	"fmt"
	"os"
)

// MonsterTemplate ครอบคลุมทุกข้อมูลที่โหลดจาก IGC_MonsterList.xml

type MonsterTemplate struct {
	Index         int    `xml:"Index,attr"`
	Name          string `xml:"Name,attr"`
	Level         int    `xml:"Level,attr"`
	MaxLife       int    `xml:"Life,attr"`
	DamageMin     int    `xml:"DamageMin,attr"`
	DamageMax     int    `xml:"DamageMax,attr"`
	Defense       int    `xml:"Defense,attr"`
	MagicDefense  int    `xml:"MagicDefense,attr"`
	MoveRange     int    `xml:"MoveRange,attr"`
	AttackType    int    `xml:"AttackType,attr"`
	AttackRange   int    `xml:"AttackRange,attr"`
	ViewRange     int    `xml:"ViewRange,attr"`
	MoveSpeed     int    `xml:"MoveSpeed,attr"`
	AttackSpeed   int    `xml:"AttackSpeed,attr"`
	RegenTime     int    `xml:"RegenTime,attr"`
	Attribute     int    `xml:"Attribute,attr"`
	ItemDropRate  int    `xml:"ItemDropRate,attr"`
	MoneyDropRate int    `xml:"MoneyDropRate,attr"`
	MaxItemLevel  int    `xml:"MaxItemLevel,attr"`
	IndexStr      string `xml:"IndexStr,attr"`
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
