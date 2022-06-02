package main

import (
	"fmt"
	"os/exec"
	// "regexp"
	"strings"
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
	type Item struct {
		name        string
		exec        string
		genericName string
	}

	itemName := ""
	itemExec := ""
	itemGenericName := ""

	maxNameLen := 0
	maxExecLen := 0
	maxGenericNameLen := 0

	ignore := true

	var s []Item

	addToHashList := func() {
		if len(itemName) > maxNameLen {
			maxNameLen = len(itemName)
		}

		if len(itemExec) > maxExecLen {
			maxExecLen = len(itemExec)
		}

		if len(itemGenericName) > maxGenericNameLen {
			maxGenericNameLen = len(itemGenericName)
		}

		item := Item{
			name:        itemName,
			exec:        itemExec,
			genericName: itemGenericName,
		}
		s = append(s, item)

		itemName = ""
		itemExec = ""
		itemGenericName = ""
	}

	stdout, err := exec.Command(
		`rg`,
		`^Name=|^Exec=|^Comment=|^GenericName=|^\[`,
		`/usr/share/applications`,
		`--no-line-number`,
		`--no-filename`,
		`--no-heading`,
	).Output()

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	lines := strings.Split(string(stdout), "\n")

	for _, line := range lines {
		if line == "[Desktop Entry]" && ignore == true {
			ignore = false
		}

		if strings.HasPrefix(line, "[Desktop Action") {
			ignore = true

			continue
		}

		if line == "[Desktop Entry]" && itemName != "" {
			addToHashList()

			continue
		}

		if strings.HasPrefix(line, "Name=") && ignore == false {
			itemName = line[5:]

			continue
		}

		if strings.HasPrefix(line, "Exec=") && ignore == false {
			itemExec = line[5:]

			continue
		}

		if strings.HasPrefix(line, "GenericName=") && ignore == false {
			itemGenericName = line[12:]

			continue
		}
	}

	m := make(map[string]string)
	dmenuInput := ""

	for _, item := range s {
		separator := " | "
		key := fillString(item.name, maxNameLen) + separator + fillString(item.genericName, maxGenericNameLen) + separator + item.exec + "\n"

		m[key] = item.exec
		dmenuInput = dmenuInput + key
	}

	stdout, err = exec.Command("sh", "-ce", "echo -e '"+dmenuInput+"' | dmenu -i -l 20").Output()

	if err != nil {
		fmt.Println(err.Error())
		return
	}
// https://www.geeksforgeeks.org/golang-replacing-all-string-which-matches-with-regular-expression/
	key := string(stdout)

	exec.Command("sh", "-ce", m[key]).Output()
	// %(u|U|f|F)
	// fmt.Println(m[key])
}
