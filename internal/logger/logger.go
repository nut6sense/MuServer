package logger

import (
	"fmt"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"time"
)

const (
	logDir    = "./logs"
	maxSizeMB = 256
	logPrefix = "MuLog"
)

var logger *log.Logger

func getLogFilename(index int) string {
	date := time.Now().Format("2006-01-02")
	if index == 0 {
		return fmt.Sprintf("%s-%s.log", logPrefix, date)
	}
	return fmt.Sprintf("%s-%s-%d.log", logPrefix, date, index)
}

func getNextLogFile() (*os.File, int, error) {
	_ = os.MkdirAll(logDir, os.ModePerm)
	index := 0

	for {
		filename := filepath.Join(logDir, getLogFilename(index))
		info, err := os.Stat(filename)
		if os.IsNotExist(err) {
			file, err := os.Create(filename)
			return file, index, err
		}
		if err == nil && info.Size() < maxSizeMB*1024*1024 {
			file, err := os.OpenFile(filename, os.O_APPEND|os.O_WRONLY, 0644)
			return file, index, err
		}
		index++
	}
}

func Init() error {
	_ = os.MkdirAll(logDir, os.ModePerm)
	cleanupOldLogs()

	file, _, err := getNextLogFile()
	if err != nil {
		return err
	}
	logger = log.New(file, "", log.Ltime)
	return nil
}

// ----------- Log ระดับต่าง ๆ -----------

func LogSql(message string) {
	logWithLevel("[SQL]", message)
}

func LogInfo(message string) {
	logWithLevel("[INF]", message)
}

func LogWarn(message string) {
	logWithLevel("[WRN]", message)
}

func LogError(message string) {
	logWithLevel("[ERR]", message)
}

func LogCritical(message string) {
	logWithLevel("[CRT]", message)
	logWithLevel("[CRT]", "Server Stoped")

	// เรียก popup.exe แสดงข้อความ
	cmd := exec.Command("./popup.exe", message)
	err := cmd.Start()
	if err != nil {
		log.Println("ไม่สามารถเปิด popup:", err)
	}

	// ปิดโปรแกรมทันที (popup.exe ยังอยู่)
	os.Exit(1)
}

func logWithLevel(level string, message string) {
	file, _, err := getNextLogFile()
	if err != nil {
		fmt.Println("[FALLBACK]", level, message)
		return
	}
	defer file.Close()
	logger = log.New(file, "", log.Ltime)
	logger.Println(level, message)
}

func cleanupOldLogs() {
	files, err := os.ReadDir(logDir)
	if err != nil {
		return
	}

	cutoff := time.Now().AddDate(0, 0, -90) // ย้อนหลัง 90 วัน

	for _, file := range files {
		if !file.Type().IsRegular() {
			continue
		}
		path := filepath.Join(logDir, file.Name())

		info, err := os.Stat(path)
		if err == nil && info.ModTime().Before(cutoff) {
			os.Remove(path)
		}
	}
}
