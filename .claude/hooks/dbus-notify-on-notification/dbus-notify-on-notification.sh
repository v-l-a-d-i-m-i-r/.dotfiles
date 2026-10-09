#!/bin/bash
# dbus-notify-on-notification.sh — desktop notification when Claude needs input

input=$(cat)
cwd=$(jq -r '.cwd // empty' <<< "$input")
message=$(jq -r '.message // "Claude is waiting for your input"' <<< "$input")

title="Claude Code: $(basename "${cwd:-$PWD}")"
branch=$(git -C "${cwd:-$PWD}" branch --show-current 2>/dev/null)
[ -n "$branch" ] && title="$title ($branch)"

"$HOME/.claude/lib/dbus-notify/dbus-notify.sh" "$title" "$message"

exit 0
