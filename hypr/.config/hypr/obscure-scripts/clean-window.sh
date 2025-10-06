#!/bin/bash
# ~/.local/bin/hypr-toggle-gaps.sh

STATE_FILE="/tmp/hypr-gaps-toggle.state"

if [ -f "$STATE_FILE" ]; then
  # Restore saved values
  mapfile -t VALUES <"$STATE_FILE"
  GAPS_IN="${VALUES[0]}"
  GAPS_OUT="${VALUES[1]}"
  ROUNDING="${VALUES[2]}"

  pkill -SIGUSR1 waybar
  hyprctl keyword decoration:inactive_opacity 0.9
  hyprctl keyword decoration:active_opacity 0.97
  hyprctl keyword general:border_size 2
  hyprctl keyword general:gaps_in "$GAPS_IN"
  hyprctl keyword general:gaps_out "$GAPS_OUT"
  hyprctl keyword decoration:rounding "$ROUNDING"

  rm "$STATE_FILE"
else
  # Save current values
  GAPS_IN=$(hyprctl getoption general:gaps_in -j | jq -r '.custom' 2>/dev/null || echo "2 2 2 2")
  GAPS_OUT=$(hyprctl getoption general:gaps_out -j | jq -r '.custom' 2>/dev/null || echo "4 4 4 4")
  ROUNDING=$(hyprctl getoption decoration:rounding -j | jq -r '.int' 2>/dev/null || echo 8)

  {
    echo "$GAPS_IN"
    echo "$GAPS_OUT"
    echo "$ROUNDING"
  } >"$STATE_FILE"
  pkill -SIGUSR1 waybar
  hyprctl keyword decoration:inactive_opacity 1
  hyprctl keyword decoration:active_opacity 1
  hyprctl keyword general:border_size 0
  # Disable gaps + rounding
  hyprctl keyword general:gaps_in "0 0 0 0"
  hyprctl keyword general:gaps_out "0 0 0 0"
  hyprctl keyword decoration:rounding 0
fi
