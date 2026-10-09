#!/bin/bash
# dbus-notify.sh <title> <body> — send a desktop notification with the Claude icon
# Shared by the dbus-notify-on-* hooks.

# Timeouts in seconds. Set them in the environment of the caller.
#   DBUS_NOTIFY_EXPIRE_TIMEOUT: the daemon closes the notification after this time.
#   DBUS_NOTIFY_LISTEN_TIMEOUT: the click listener stops after this time. Keep it
#   not shorter than the expire timeout, or late clicks are lost.
expire_timeout=${DBUS_NOTIFY_EXPIRE_TIMEOUT:-15}
listen_timeout=${DBUS_NOTIFY_LISTEN_TIMEOUT:-30}

# Bell mode: notify only when tmux flagged the window of this pane with a bell.
# The send-bell hook rings it. tmux does not flag the window the user looks at.
# The short sleep gives tmux time to process the bell.
if [ -n "$TMUX_PANE" ]; then
  sleep 0.3
  [ "$(tmux display-message -p -t "$TMUX_PANE" '#{window_bell_flag}' 2>/dev/null)" = 1 ] || exit 0
fi

# Previous behaviour: skip when the user already looks at this tmux pane:
# the pane is visible and a client of its session has terminal focus.
# if [ -n "$TMUX_PANE" ]; then
#   read -r visible session < <(tmux display-message -p -t "$TMUX_PANE" \
#     '#{&&:#{window_active},#{pane_active}} #{session_id}' 2>/dev/null)
#   if [ "$visible" = 1 ] && tmux list-clients -t "$session" -F '#{client_flags}' 2>/dev/null | grep -qw focused; then
#     exit 0
#   fi
# fi

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

latest_client() { sort -rn | head -1 | awk '{print $NF}'; }

# Show the session, window and pane of the notifying pane in the client the user works with:
# the client that got terminal focus last (tmux hook client-focus-in sets @last_focus_client),
# else the most recently active focused client, else the most recently active client.
focus_pane() {
  target=$(tmux display-message -p -t "$TMUX_PANE" '#{session_id} #{window_id} #{pane_id}')
  read -r session window pane <<< "$target"
  clients=$(tmux list-clients -F '#{client_activity} #{client_flags} #{client_name}')
  client=$(tmux show -gqv @last_focus_client)
  if [ -z "$client" ] || ! grep -qF " $client" <<< "$clients"; then
    client=$(grep -w focused <<< "$clients" | latest_client)
  fi
  [ -z "$client" ] && client=$(latest_client <<< "$clients")
  tmux select-window -t "$window" \; select-pane -t "$pane"
  [ -n "$client" ] && tmux switch-client -c "$client" -t "$session"
}

# Wait for a click on notification $1, then focus the tmux pane. Ends when the notification closes.
wait_for_click() {
  timeout "$listen_timeout" gdbus monitor --session \
    --dest org.freedesktop.Notifications \
    --object-path /org/freedesktop/Notifications |
  while read -r line; do
    case $line in
      *ActionInvoked*"uint32 $1,"*) focus_pane; break ;;
      *NotificationClosed*"uint32 $1,"*) break ;;
    esac
  done
}

actions='[]'
# The key carries the host name. The host helper dbus-notify-i3-focus uses it to focus the
# terminal window, because the tmux title ends with "@<host name>".
[ -n "$TMUX_PANE" ] && actions="['open:$(hostname)', 'Open']"

reply=$(gdbus call --session \
  --dest org.freedesktop.Notifications \
  --object-path /org/freedesktop/Notifications \
  --method org.freedesktop.Notifications.Notify \
  'Claude Code' 0 '' "$1" "$body" "$actions" "{'image-data': $icon}" "$((expire_timeout * 1000))")

# Detach the listener so the hook returns at once.
id=$(sed -nE 's/^\(uint32 ([0-9]+),\)$/\1/p' <<< "$reply")
if [ -n "$TMUX_PANE" ] && [ -n "$id" ]; then
  wait_for_click "$id" < /dev/null > /dev/null 2>&1 &
fi
