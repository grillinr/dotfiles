#!/bin/bash
# Merged wallpaper script combining WallpaperSelect.sh UI and wallpaper.sh features

# WALLPAPERS DIRECTORY
WALLPAPER_DIR="/home/nathan/wallpapers/walls"
SCRIPTSDIR="$HOME/.config/hypr/scripts"

# Variables
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')
FPS=60
TYPE="any"
DURATION=0.5
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Retrieve image files
mapfile -d '' PICS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)
RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME=". random"

# Rofi menu
rofi_command="rofi -i -show -dmenu -config ~/.config/rofi/config-wallpaper.rasi"
menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))
  printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"
  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    if [[ ! "$pic_name" =~ \.gif$ ]]; then
      printf "%s\x00icon\x1f%s\n" "$(echo "$pic_name" | cut -d. -f1)" "$pic_path"
    else
      printf "%s\n" "$pic_name"
    fi
  done
}

# Start swww if not running
swww query || swww-daemon --format xrgb

# Wallpaper selection and application
main() {
  choice=$(menu | $rofi_command | xargs)
  if [[ -z "$choice" ]]; then
    echo "No choice selected. Exiting."
    exit 0
  fi
  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    swww img -o "$focused_monitor" "$RANDOM_PIC" $SWWW_PARAMS
  else
    for pic in "${PICS[@]}"; do
      if [[ "$(basename "$pic")" == "$choice"* ]]; then
        swww img -o "$focused_monitor" "$pic" $SWWW_PARAMS
        FULL_PATH="$pic"
        break
      fi
    done
  fi

  # Apply pywal theme
  wal -i "$FULL_PATH" -n --cols16
  swaync-client --reload-css
  cat ~/.cache/wal/colors-kitty.conf >~/.config/kitty/current-theme.conf
  pywalfox update

  # Refresh scripts
  "$SCRIPTSDIR/WallustSwww.sh"
  sleep 2
  "$SCRIPTSDIR/Refresh.sh"
  echo "Wallpaper and themes updated successfully!"
}

main
