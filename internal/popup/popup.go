package popup

import (
	"log"
	"syscall"
	"unsafe"
)

const (
	MB_OK              = 0x00000000 //ปุ่ม OK อย่างเดียว
	MB_ICONERROR       = 0x00000010 //ไอคอนรูปกากบาทสีแดง (❌)
	MB_ICONWARNING     = 0x00000030 //ไอคอนรูปเครื่องหมายตกใจ (⚠️)
	MB_ICONINFORMATION = 0x00000040 //ไอคอนรูป i ข้อมูล (ℹ️)
)

func ShowPopup(title, message string, iconFlag uintptr) {
	user32 := syscall.NewLazyDLL("user32.dll")
	messageBox := user32.NewProc("MessageBoxW")

	titlePtr, err := syscall.UTF16PtrFromString(title)
	if err != nil {
		log.Println("Title conversion error:", err)
		return
	}
	messagePtr, err := syscall.UTF16PtrFromString(message)
	if err != nil {
		log.Println("Message conversion error:", err)
		return
	}

	messageBox.Call(
		0,
		uintptr(unsafe.Pointer(messagePtr)),
		uintptr(unsafe.Pointer(titlePtr)),
		MB_OK|iconFlag,
	)
}
