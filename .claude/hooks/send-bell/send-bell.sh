#!/bin/bash
# send-bell.sh — ring the terminal bell when Claude needs attention or stops.
# tmux marks the window with a bell flag (see "bell-action" and "monitor-bell").

input=$(cat)

# No bell for the idle reminder.
[ "$(jq -r '.notification_type // empty' <<< "$input")" = idle_prompt ] && exit 0

jq -nc --arg seq $'\a' '{terminalSequence: $seq}'
