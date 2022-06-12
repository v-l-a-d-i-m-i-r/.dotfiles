package main

import (
	"fmt"
	"os"
	"os/exec"
)

func fillString(string string, length int) string {
	diff := length - len(string)
	resultString := string

	for i := 0; i < diff; i++ {
		resultString = resultString + " "
	}

	return resultString
}

func main() {
	m := map[string]string{
		"Shutdown":  "systemctl poweroff",
		"Reboot":    "systemctl reboot",
		"Hibernate": "systemctl hibernate",
		"Suspend":   "systemctl suspend",
		"Halt":      "systemctl halt",
		// Lock = "LOCKSCRIPT:-i3lock --color=${BG_COLOR#"#"}}"
		"Logout": "i3-msg exit",
	}

	maxTitleLen := len(m["Hibernate"])
	dmenuInput := ""
	cm := make(map[string]string)

	for title, command := range m {
		separator := " | "
		key := fillString(title, maxTitleLen) + separator + command + "\n"

		cm[key] = command
		dmenuInput = dmenuInput + key
	}

	command := "echo -e '" + dmenuInput + "' | dmenu '-i'"

	for _, arg := range os.Args[1:] {
		command = command + " '" + arg + "'"
	}

  stdout, err := exec.Command("sh", "-ce", command).CombinedOutput()
	if err != nil {
		fmt.Println(err.Error())
		fmt.Println(string(stdout))

		return
	}

	key := string(stdout)

	exec.Command("sh", "-ce", cm[key]).Output()
}
