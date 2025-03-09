package database

type Chanel struct {
	ChanelCode int    `gorm:"column:ChanelCode;primaryKey"`
	ServerCode int    `gorm:"column:ServerCode;not null"`
	Visible    int    `gorm:"column:Visible;not null"`
	Name       string `gorm:"column:Name;type:varchar(255);not null"`
}

func (Chanel) TableName() string {
	return "Chanel"
}
