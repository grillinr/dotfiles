#!/bin/bash
while true; do
  if grep -q closed /proc/acpi/button/lid/*/state; then
    # Check for external monitors, excluding eDP
    if hyprctl monitors | grep -E '\b(DP-|HDMI-)'; then
      hyprctl keyword monitor "eDP-1,disable"
    else
      systemctl suspend
    fi
  else
    # When lid is open and no external monitors
    if ! hyprctl monitors | grep -E '\b(DP-|HDMI-)'; then
      hyprctl keyword monitor "eDP-1,preferred,auto,1.2"
    fi
  fi
  sleep 2
done
