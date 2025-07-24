#!/bin/bash

if pgrep -x tofi >/dev/null; then
  killall -q tofi
  exit
fi

choice=$(printf "%s\n" "Power Off" "Restart" "Suspend" "Hibernate" "Lock" "Log Out" | tofi --width 165 --height 260)

case "$choice" in
  "Power Off")
    systemctl poweroff
    ;;
  "Restart")
    systemctl reboot
    ;;
  "Suspend")
    systemctl suspend
    ;;
  "Hibernate")
    systemctl hibernate
    ;;
  "Lock")
    hyprlock
    ;;
  "Log Out")
    case "$DESKTOP_SESSION" in
      hyprland | hyprland-uwsm)
        hyprctl dispatch exit 1
        ;;
      sway)
        swaymsg exit
        ;;
    esac
    ;;
esac
