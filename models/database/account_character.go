package database

type AccountCharacter struct {
	Id                       string  `gorm:"column:Id;primaryKey"`
	GameID1                  *string `gorm:"column:GameID1"`
	GameID2                  *string `gorm:"column:GameID2"`
	GameID3                  *string `gorm:"column:GameID3"`
	GameID4                  *string `gorm:"column:GameID4"`
	GameID5                  *string `gorm:"column:GameID5"`
	GameIDC                  *string `gorm:"column:GameIDC"`
	MoveCnt                  *int    `gorm:"column:MoveCnt"`
	Summoner                 int     `gorm:"column:Summoner"`
	WarehouseExpansion       int     `gorm:"column:WarehouseExpansion"`
	RageFighter              int     `gorm:"column:RageFighter"`
	SecCode                  int     `gorm:"column:SecCode"`
	ILC                      int     `gorm:"column:ILC"`
	GrowLancer               int     `gorm:"column:GrowLancer"`
	MagicGladiator           int     `gorm:"column:MagicGladiator"`
	DarkLord                 int     `gorm:"column:DarkLord"`
	RuneWizard               int     `gorm:"column:RuneWizard"`
	Slayer                   int     `gorm:"column:Slayer"`
	GunCrusher               *int    `gorm:"column:GunCrusher"`
	LightWizard              *int    `gorm:"column:LightWizard"`
	LemuriaMage              *int    `gorm:"column:LemuriaMage"`
	IllusionKnight           *int    `gorm:"column:IllusionKnight"`
	LastCreateDate           *int64  `gorm:"column:LastCreateDate"`
	CharacterCreateCountUsed int     `gorm:"column:CharacterCreateCountUsed"`
}

func (AccountCharacter) TableName() string {
	return "AccountCharacter"
}
