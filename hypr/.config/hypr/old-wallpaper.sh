#!/bin/bash

# --- CONFIG ---
WALLPAPER_DIR="$HOME/repos/dotfiles/wallpapers"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
CACHE_FILE="$HOME/.cache/current_wallpaper"

# --- CHECK DEPENDENCIES ---
for cmd in jq rofi hyprctl hyprpaper; do
  if ! command -v $cmd &>/dev/null; then
    echo "Error: $cmd is not installed."
    exit 1
  fi
done

# Start hyprpaper if not running
if ! pgrep -x "hyprpaper" >/dev/null; then
  hyprpaper &
  sleep 1
fi

# --- GET FOCUSED MONITOR ---
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
if [[ -z "$focused_monitor" ]]; then
  echo "Error: Could not detect focused monitor."
  exit 1
fi

# --- LOAD WALLPAPERS ---
mapfile -d '' PICS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) -print0)

# --- ROFI MENU ---
rofi_command="rofi -dmenu -i -show -config ~/.config/rofi/config-wallpaper.rasi"

menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))
  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    printf "%s\x00icon\x1f%s\n" "${pic_name%.*}" "$pic_path"
  done
}

# --- APPLY WALLPAPER ---
set_wallpaper() {
  local wp="$1"
  local mon="$2"

  echo "Setting wallpaper :: Monitor: $mon :: Image: $wp"

  # 1. Runtime Change (IPC)
  # Syntax: hyprctl hyprpaper command "arg1,arg2"

  # Preload
  hyprctl hyprpaper preload "$wp"

  # Wallpaper: COMMAS REQUIRED.
  # "monitor,path"
  hyprctl hyprpaper wallpaper "$mon, $wp"

  # Unload unused
  hyprctl hyprpaper unload unused

  # 2. Persistence (hyprpaper.conf)
  if [[ -f "$CONFIG_FILE" ]]; then
    if ! grep -qF "preload = $wp" "$CONFIG_FILE"; then
      echo "preload = $wp" >>"$CONFIG_FILE"
    fi
    sed -i "\,^wallpaper = $mon,d" "$CONFIG_FILE"
    echo "wallpaper = $mon,$wp" >>"$CONFIG_FILE"
  else
    {
      echo "ipc = on"
      echo "splash = false"
      echo "preload = $wp"
      echo "wallpaper = $mon,$wp"
    } >"$CONFIG_FILE"
  fi

  # 3. Cache & Hyprlock Sync
  echo "$wp" >"$CACHE_FILE"
  export CURRENT_WALLPAPER="$wp"

  if [[ -f "$HYPRLOCK_CONF" ]]; then
    sed -i "s|path[[:space:]]*=[[:space:]]*.*|path = $wp|" "$HYPRLOCK_CONF"
    echo "Hyprlock config updated."
  fi
}

# --- MAIN EXECUTION ---
main() {
  choice=$(menu | $rofi_command)

  if [[ -z "$choice" ]]; then
    echo "No wallpaper selected."
    exit 0
  fi

  for pic in "${PICS[@]}"; do
    filename=$(basename "$pic")
    filename_no_ext="${filename%.*}"
    if [[ "$filename_no_ext" == "$choice" ]]; then
      set_wallpaper "$pic" "$focused_monitor"
      break
    fi
  done
}

main
