#!/bin/bash
WALLPAPER_DIR="/home/nathan/wallpapers/walls"
SELECTED_WALLPAPER=$(find "$WALLPAPER_DIR" -type f -exec basename {} \; | wofi -c ~/.config/wofi/config1 --show dmenu --prompt "Select Wallpaper:")

FULL_PATH=$(find "$WALLPAPER_DIR" -type f -name "$SELECTED_WALLPAPER")

swww img "$FULL_PATH" --transition-type any --transition-fps 60 --transition-duration .5

wal -i "$FULL_PATH" -n --cols16
swaync-client --reload-css
cat ~/.cache/wal/colors-kitty.conf >~/.config/kitty/current-theme.conf
pywalfox update
