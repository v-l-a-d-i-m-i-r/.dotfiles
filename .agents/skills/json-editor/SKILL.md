---
name: json-editor
description: Full-featured JSON CLI tool for getting, setting, deleting, and searching values in JSON files using dot-path notation. Supports absolute and ~ paths.
---

# JSON Editor Skill

This skill allows the agent to interact with JSON files using the `json-cli` utility located at `~/.bin/json-cli`. It supports complex operations like deep searching and property deletion.

## Instructions
1. **Formatting**: Always maintains a **2-space indentation** by default.
2. **Path Support**: Full support for relative, absolute (`/`), and home (`~`) paths.
3. **Value Parsing**: Automatically handles booleans, numbers, arrays, and nested JSON objects passed as strings.
4. **Operation Choice**:
  - Use `--get` to read a value.
  - Use `--set` with `--value` to create or update a value.
  - Use `--delete` to remove a key or an array element.
  - Use `--exists` to check for a key before performing logic.
  - Use `--find` to locate paths that contain a specific value.

## Command Reference

### Reading & Searching
- **Get a value**:
  `~/.bin/json-cli -f <file> --get <path>`
- **Check existence**:
  `~/.bin/json-cli -f <file> --exists <path>`
- **Find all paths with a specific value**:
  `~/.bin/json-cli -f <file> --find <value>`

### Modifying
- **Set/Update value**:
  `~/.bin/json-cli -f <file> --set <path> --value <new_value>`
- **Delete key/index**:
  `~/.bin/json-cli -f <file> --delete <path>`

## Examples for Gemini
- **Setting a boolean in global settings**:
  `~/.bin/json-cli -f "~/.gemini/settings.json" --set "experimental.skills" --value true`

- **Removing a script from package.json**:
  `~/.bin/json-cli -f "./package.json" --delete "scripts.test"`

- **Finding where 'nvim' is defined**:
  `~/.bin/json-cli -f "~/.gemini/settings.json" --find "nvim"`

- **Reading a nested UI setting**:
  `~/.bin/json-cli -f "./config.json" --get "ui.theme.color"`

## Exit Codes Reference
- **0**: Success / Path exists.
- **1**: Error / Path not found.

---

## Safety Guidelines
- When deleting, confirm the path with the user if it looks critical.
- If the agent needs to move a value, it should `--get` it first, then `--set` it at the new path, and finally `--delete` the old one.
