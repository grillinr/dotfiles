#!/bin/bash
# Generic TUI overlay toggle script
# Usage: toggle-overlay.sh <window-class> <command> [args...]

WINDOW_CLASS="$1"
shift  # Remove first argument
LAUNCH_CMD=("$@")  # All remaining arguments become the command array

# Check for dependencies
if ! command -v hyprctl &> /dev/null || ! command -v jq &> /dev/null; then
  exit 1
fi

# Find window with this class
WINDOW_ADDR=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$WINDOW_CLASS\") | .address" | head -n 1)

if [ -n "$WINDOW_ADDR" ]; then
  # Window exists, close it
  hyprctl dispatch closewindow "address:$WINDOW_ADDR"
else
  # Window doesn't exist, launch it
  "${LAUNCH_CMD[@]}" &
fi
