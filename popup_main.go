package main

import (
	"os"
	"syscall"
	"unsafe"
)

func main() {
	title := "Critical Error"
	message := "Unknown Error"

	if len(os.Args) > 1 {
		message = os.Args[1]
	}

	user32 := syscall.NewLazyDLL("user32.dll")
	messageBox := user32.NewProc("MessageBoxW")

	titlePtr, _ := syscall.UTF16PtrFromString(title)
	messagePtr, _ := syscall.UTF16PtrFromString(message)

	messageBox.Call(
		0,
		uintptr(unsafe.Pointer(messagePtr)),
		uintptr(unsafe.Pointer(titlePtr)),
		uintptr(0x10), // MB_ICONERROR
	)
}
