package main

import (
	"fmt"
	"os/exec"
	// "regexp"
	"strings"
)

var name = ""

// exec := ""
var ignore = true

type item struct {
	name        string
	exec        string
	comment     string
	genericName string
}

var m = make(map[string]item)

func addToHashList() {

}

func main() {
	cmd := exec.Command(
		`rg`,
		`^Name=|^Exec=|^Comment=|^GenericName=|^\[`,
		`/usr/share/applications`,
		`--no-line-number`,
		`--no-filename`,
		`--no-heading`,
	)

	stdout, err := cmd.Output()

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	lines := strings.Split(string(stdout), "\n")

	for _, line := range lines {
		// fmt.Print(line)
		// fmt.Print("\n")
		if line == "[Desktop Entry]" && ignore == true {
			ignore = false
		}

		if !strings.HasPrefix(line, "[Desktop Action") {
			ignore = true

			continue
		}

		if line == "[Desktop Entry]" && name != "" {
			// add to hashList

			continue
		}
	}
}
