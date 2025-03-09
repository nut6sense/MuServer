package database

import (
	"time"
)

type ConnectionHistory struct {
	ID         int       `gorm:"primaryKey;autoIncrement"`
	AccountID  string    `gorm:"type:varchar(10);column:AccountID;"`
	ServerName string    `gorm:"type:varchar(40);column:ServerName;"`
	IP         string    `gorm:"type:varchar(16);column:IP;"`
	Date       time.Time `gorm:"type:datetime;column:Date;"`
	State      string    `gorm:"type:varchar(12);column:State;"`
	HWID       string    `gorm:"type:varchar(100);column:HWID;"`
}

func (ConnectionHistory) TableName() string {
	return "ConnectionHistory"
}
