#!/bin/bash

# Game Mode Script
# Toggles performance settings and a restricted keybinding submap for gaming
# Usage: ./gamemode.sh

STATE_FILE="/tmp/hypr-gamemode.state"

# Check if we are currently in Game Mode
if [ -f "$STATE_FILE" ]; then
  # === DISABLE GAME MODE (Restore Normal) ===
  
  # 1. Remove state file first
  rm "$STATE_FILE"

  # 2. Restore Hyprland settings
  # Explicitly reset submap to ensure we exit gamemode
  hyprctl dispatch submap reset
  
  # 'hyprctl reload' resets keywords to defaults
  hyprctl reload

  # Restart idle daemon (since exec-once won't re-run on reload)
  if ! pgrep -x "hypridle" >/dev/null; then
    hypridle &
  fi

  # 3. Restore Notifications
  if pgrep -x "mako" >/dev/null; then makoctl mode -r do-not-disturb; fi
  if pgrep -x "dunst" >/dev/null; then dunstctl set-paused false; fi

  notify-send -e -t 2000 "System" "Normal Mode Enabled"

else
  # === ENABLE GAME MODE (Max Performance & Input Safety) ===

  # 1. Set state flag
  touch "$STATE_FILE"

  # 2. Kill Idle Daemon
  # Prevents screen dimming/locking during cutscenes or controller play
  killall hypridle

  # 3. Apply Performance Settings
  # - Disable animations, blur, shadows (decoration:shadow:enabled)
  # - Remove gaps, rounding, borders
  # - Force VFR OFF (constant refresh rate for smoother frame pacing)
  hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:shadow:enabled 0;\
        keyword decoration:blur:enabled 0;\
        keyword misc:vfr 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1;\
        keyword decoration:inactive_opacity 1;\
        keyword general:border_size 0;\
        keyword input:kb_options lv3:ralt_switch,leftmeta:super"

  # 4. Silence Notifications
  if pgrep -x "mako" >/dev/null; then makoctl mode -a do-not-disturb; fi
  if pgrep -x "dunst" >/dev/null; then dunstctl set-paused true; fi

  # 5. Activate Game Mode Submap
  # This locks the keyboard to only the binds defined in the 'gamemode' submap
  hyprctl dispatch submap gamemode

  notify-send -e -t 2000 "System" "Game Mode Enabled"
fi
