package main

import (
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"sort"
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
		`-L`,
		`--no-line-number`,
		`--no-filename`,
		`--no-heading`,
	).CombinedOutput()

	if err != nil {
		fmt.Println(err.Error())
		fmt.Println(string(stdout))

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

	if itemName != "" {
		addToHashList()
	}

	m := make(map[string]string)
	var dmenuInput []string

	for _, item := range s {
		separator := " | "
		key := fillString(item.name, maxNameLen) + separator + fillString(item.genericName, maxGenericNameLen) + separator + item.exec + "\n"

		m[key] = item.exec
		dmenuInput = append(dmenuInput, key)
	}

	sort.Strings(dmenuInput)
	dmenuInputString := strings.Join(dmenuInput, "")

	command := "echo -e '" + dmenuInputString + "' | dmenu '-i'"

	for _, arg := range os.Args[1:] {
		command = command + " '" + arg + "'"
	}

	stdout, err = exec.Command("sh", "-ce", command).CombinedOutput()
	if err != nil {
		fmt.Println(err.Error())
		fmt.Println(string(stdout))

		return
	}

	key := string(stdout)
	r := regexp.MustCompile(`%(u|U|f|F)`)
	cmd := r.ReplaceAllString(m[key], "")

	exec.Command("sh", "-ce", cmd).Output()
}
