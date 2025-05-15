package models

import (
	"encoding/xml"
	"fmt"
	"os"
)

// MonsterTemplate ครอบคลุมทุกข้อมูลที่โหลดจาก IGC_MonsterList.xml

type MonsterTemplate struct {
	Index                  int    `xml:"Index,attr"`
	IsTrap                 int    `xml:"IsTrap,attr"`
	Name                   string `xml:"Name,attr"`
	Level                  int    `xml:"Level,attr"`
	HP                     int    `xml:"HP,attr"`
	MP                     int    `xml:"MP,attr"`
	DamageMin              int    `xml:"DamageMin,attr"`
	DamageMax              int    `xml:"DamageMax,attr"`
	ExtraDamageMin         int    `xml:"ExtraDamageMin,attr"`
	ExtraDamageMax         int    `xml:"ExtraDamageMax,attr"`
	Defense                int    `xml:"Defense,attr"`
	MagicDefense           int    `xml:"MagicDefense,attr"`
	ExtraDefense           int    `xml:"ExtraDefense,attr"`
	AttackRate             int    `xml:"AttackRate,attr"`
	BlockRate              int    `xml:"BlockRate,attr"`
	MoveRange              int    `xml:"MoveRange,attr"`
	AttackType             int    `xml:"AttackType,attr"`
	AttackRange            int    `xml:"AttackRange,attr"`
	ViewRange              int    `xml:"ViewRange,attr"`
	MoveSpeed              int    `xml:"MoveSpeed,attr"`
	AttackSpeed            int    `xml:"AttackSpeed,attr"`
	RegenTime              int    `xml:"RegenTime,attr"`
	Attribute              int    `xml:"Attribute,attr"`
	IceRes                 int    `xml:"IceRes,attr"`
	PoisonRes              int    `xml:"PoisonRes,attr"`
	LightRes               int    `xml:"LightRes,attr"`
	FireRes                int    `xml:"FireRes,attr"`
	PentagramMainAttrib    int    `xml:"PentagramMainAttrib,attr"`
	PentagramAttribPattern int    `xml:"PentagramAttribPattern,attr"`
	PentagramDamageMin     int    `xml:"PentagramDamageMin,attr"`
	PentagramDamageMax     int    `xml:"PentagramDamageMax,attr"`
	PentagramAttackRate    int    `xml:"PentagramAttackRate,attr"`
	PentagramDefenseRate   int    `xml:"PentagramDefenseRate,attr"`
	PentagramDefense       int    `xml:"PentagramDefense,attr"`
	EliteMonster           int    `xml:"EliteMonster,attr"`
	PunishImmune           int    `xml:"PunishImmune,attr"`
	DamageAbsorption       int    `xml:"DamageAbsorption,attr"`
	CriticalDamageRes      int    `xml:"CriticalDamageRes,attr"`
	ExcellentDamageRes     int    `xml:"ExcellentDamageRes,attr"`
	DebuffApplyRes         int    `xml:"DebuffApplyRes,attr"`
	DamageCorrection       int    `xml:"DamageCorrection,attr"`
	ExpLevel               int    `xml:"ExpLevel,attr"`
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
