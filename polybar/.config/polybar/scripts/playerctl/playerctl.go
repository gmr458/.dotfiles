package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	outputBytes, _ := exec.Command("playerctl", "status").Output()

	outputStr := strings.TrimSpace(string(outputBytes))

	switch outputStr {
	case "Playing":
		fmt.Println("%{A1:playerctl pause:}󰏤%{A}󰎇 ")
	case "Paused":
		fmt.Println("%{A1:playerctl play:}󰐊%{A}󰎇 ")
	default:
		fmt.Println("")
	}
}
