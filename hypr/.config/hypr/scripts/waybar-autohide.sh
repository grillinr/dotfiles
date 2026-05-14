#!/bin/bash

set -u

WAYBAR_CMD=${WAYBAR_CMD:-waybar}
POLL_INTERVAL=${POLL_INTERVAL:-0.05}
SHOW_THRESHOLD=${SHOW_THRESHOLD:-2}
HIDE_THRESHOLD=${HIDE_THRESHOLD:-40}

hide_bar() {
  pkill -USR1 -x waybar
}

show_bar() {
  pkill -USR2 -x waybar
}

get_cursor_y() {
  hyprctl cursorpos 2>/dev/null | {
    IFS=, read -r _ y
    printf '%s\n' "${y# }"
  }
}

wait_for_waybar() {
  while ! pgrep -x waybar >/dev/null 2>&1; do
    sleep 0.2
  done
}

"$WAYBAR_CMD" >/dev/null 2>&1 &
wait_for_waybar

visible=1

while true; do
  cursor_y=$(get_cursor_y)

  if [[ -z ${cursor_y:-} ]]; then
    sleep "$POLL_INTERVAL"
    continue
  fi

  cursor_y=${cursor_y%.*}

  if (( visible == 0 )); then
    if (( cursor_y <= SHOW_THRESHOLD )); then
      show_bar
      visible=1
    fi
  else
    if (( cursor_y > HIDE_THRESHOLD )); then
      hide_bar
      visible=0
    fi
  fi

  sleep "$POLL_INTERVAL"
done
