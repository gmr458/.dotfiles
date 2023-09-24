#!/bin/bash

if (ps -a | grep tofi >/dev/null); then
  killall -q tofi
else
  case $(printf "%s\n" "Power Off" "Restart" "Suspend" "Hibernate" "Lock" "Log Out" | tofi --width 180 --height 260) in
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
    swaylock
    ;;
  "Log Out")
    if [[ "$DESKTOP_SESSION" == "hyprland" ]]; then
      hyprctl dispatch exit 1
    elif [[ "$DESKTOP_SESSION" == "sway" ]]; then
      swaymsg exit
    fi
    ;;
  esac
fi
