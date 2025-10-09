#!/bin/bash
# Wallpaper selector using Hyprpaper + Hyprlock sync

# --- CONFIG ---
WALLPAPER_DIR="$HOME/repos/dotfiles/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
HYPRLOCK_CONF="$HOME/.config/hypr/hyprlock.conf"
CACHE_FILE="$HOME/.cache/current_wallpaper"

# --- GET MONITOR INFO ---
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# --- LOAD WALLPAPERS ---
mapfile -d '' PICS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

# --- ROFI MENU ---
rofi_command="rofi -i -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"
menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))
  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
  done
}

# --- START HYPRPAPER IF NEEDED ---
if ! pgrep -x "hyprpaper" >/dev/null; then
  echo "Starting hyprpaper..."
  hyprpaper &
  sleep 0.5
fi

# --- APPLY WALLPAPER ---
set_wallpaper() {
  local wp="$1"
  echo "Setting wallpaper for monitor: $focused_monitor -> $wp"

  # Update hyprpaper
  hyprctl hyprpaper preload "$wp"
  hyprctl hyprpaper wallpaper "$focused_monitor,$wp"
  hyprctl hyprpaper unload unused

  # Update hyprpaper.conf for persistence
  if [[ -f "$CONFIG_FILE" ]]; then
    sed -i "/preload =/d" "$CONFIG_FILE"
    sed -i "/wallpaper = $focused_monitor/d" "$CONFIG_FILE"
  fi
  {
    echo "preload = $wp"
    echo "wallpaper = $focused_monitor,$wp"
  } >>"$CONFIG_FILE"

  # Cache the current wallpaper
  echo "$wp" >"$CACHE_FILE"
  export CURRENT_WALLPAPER="$wp"

  # --- SYNC WITH HYPRLOCK ---
  if [[ -f "$HYPRLOCK_CONF" ]]; then
    if grep -q "path =" "$HYPRLOCK_CONF"; then
      sed -i "s|path = .*|path = $wp|" "$HYPRLOCK_CONF"
    else
      sed -i "/^background {/a\    path = $wp" "$HYPRLOCK_CONF"
    fi
    echo "Hyprlock background updated."
  else
    echo "Warning: Hyprlock config not found at $HYPRLOCK_CONF"
  fi

  echo "Wallpaper applied successfully!"
}

# --- MAIN EXECUTION ---
main() {
  choice=$(menu | $rofi_command | xargs)
  if [[ -z "$choice" ]]; then
    echo "No wallpaper selected. Exiting."
    exit 0
  fi

  for pic in "${PICS[@]}"; do
    if [[ "$(basename "$pic")" == "$choice"* ]]; then
      set_wallpaper "$pic"
      break
    fi
  done

  # Optional: sync theme colors with pywal
  # wal -i "$CURRENT_WALLPAPER" -n --cols16
}

main
