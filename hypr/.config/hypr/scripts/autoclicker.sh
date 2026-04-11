#!/bin/bash

# Definition of the target file to store the PID
PID_FILE="/tmp/hypr_autoclicker.pid"

if [ -f "$PID_FILE" ]; then
  # If the file exists, the clicker is running. Kill it.
  PID=$(cat "$PID_FILE")
  if kill -0 "$PID" 2>/dev/null; then
    kill "$PID"
    rm "$PID_FILE"
    notify-send "Autoclicker" "Stopped"
  else
    # Stale PID file (process already dead), remove it and restart
    rm "$PID_FILE"
  fi
else
  # If file doesn't exist, start the loop in the background
  notify-send "Autoclicker" "Active"

  # The actual clicking loop
  (while true; do
    # 0xC0 is the hex code for Left Mouse Button
    ydotool click 0xC0

    # Adjust speed here (e.g., 0.01 for very fast, 1 for slow)
    sleep 1
  done) &

  # Save the background process ID to the file
  echo $! >"$PID_FILE"
fi
