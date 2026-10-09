#!/bin/bash
# dbus-notify-on-notification.sh — desktop notification when Claude needs input

export DBUS_NOTIFY_EXPIRE_TIMEOUT=30
export DBUS_NOTIFY_LISTEN_TIMEOUT=30

input=$(cat)
cwd=$(jq -r '.cwd // empty' <<< "$input")
message=$(jq -r '.message // "Claude is waiting for your input"' <<< "$input")

title="Claude Code: $(basename "${cwd:-$PWD}")"
branch=$(git -C "${cwd:-$PWD}" branch --show-current 2>/dev/null)
[ -n "$branch" ] && title="$title ($branch)"

"$HOME/.claude/lib/dbus-notify/dbus-notify.sh" "$title" "$message"

exit 0
