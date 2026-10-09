#!/bin/bash
# dbus-notify.sh <title> <body> — send a desktop notification with the Claude icon
# Shared by the dbus-notify-on-* hooks.

# Skip when the user already looks at this tmux pane.
if [ -n "$TMUX_PANE" ]; then
  visible=$(tmux display-message -p -t "$TMUX_PANE" \
    '#{&&:#{session_attached},#{&&:#{window_active},#{pane_active}}}' 2>/dev/null)
  [ "$visible" = 1 ] && exit 0
fi

dir=$(dirname "$0")
icon=$(python3 -I "$dir/icon-image-data.py" "$dir/claude-icon-48.png")

# The daemon renders the body as markup: flatten tables, escape, then map Markdown styles.
body=$(sed -E '
  /^[[:space:]]*[|][ :|-]*-[ :|-]*$/d
  /^[[:space:]]*[|]/{
    s/^[[:space:]]*[|][[:space:]]*//
    s/[[:space:]]*[|][[:space:]]*$//
    s/[[:space:]]*[|][[:space:]]*/  ·  /g
  }
  s/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g
  s/^#+ +(.*)$/<b>\1<\/b>/
  s/`([^`]+)`/<tt>\1<\/tt>/g
  s/~~([^~]+)~~/<s>\1<\/s>/g
  s/\*\*([^*]+)\*\*/<b>\1<\/b>/g
  s/\*([^* ][^*]*)\*/<i>\1<\/i>/g
' <<< "$2")

gdbus call --session \
  --dest org.freedesktop.Notifications \
  --object-path /org/freedesktop/Notifications \
  --method org.freedesktop.Notifications.Notify \
  'Claude Code' 0 '' "$1" "$body" '[]' "{'image-data': $icon}" 15000 > /dev/null
