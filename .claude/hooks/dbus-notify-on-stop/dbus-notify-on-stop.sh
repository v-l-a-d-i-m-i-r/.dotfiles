#!/bin/bash
# dbus-notify-on-stop.sh — desktop notification when Claude finishes a task

export DBUS_NOTIFY_EXPIRE_TIMEOUT=30
export DBUS_NOTIFY_LISTEN_TIMEOUT=30

input=$(cat)
cwd=$(jq -r '.cwd // empty' <<< "$input")
last=$(jq -r '.last_assistant_message // empty' <<< "$input" | head -n 8 | cut -c1-200)

title="Claude Code: $(basename "${cwd:-$PWD}")"
branch=$(git -C "${cwd:-$PWD}" branch --show-current 2>/dev/null)
[ -n "$branch" ] && title="$title ($branch)"

"$HOME/.claude/lib/dbus-notify/dbus-notify.sh" "$title" "Task finished${last:+: $last}"

exit 0
