#!/bin/bash

theme=""

help() {
  echo "script usage: $(basename $0) [-t theme-name]" >&2
  exit 1
}

while getopts ':t:?h' OPTION; do
  case "$OPTION" in
  t)
    theme=$OPTARG
    ;;
  h | ?)
    help
    ;;
  esac
done

if [[ -z $theme ]]; then
  help
else
  if (ps -a | grep tofi >/dev/null); then
    killall -q tofi
  else
    case $(printf "%s\n" "󰐥 Power Off" "󰑐 Restart" "󰖔 Suspend" "󰑻 Hibernate" "󰌾 Lock" "󰗽 Log Out" | tofi --config "$HOME/.config/tofi/powermenu_$theme") in
    "󰐥 Power Off")
      systemctl poweroff
      ;;
    "󰑐 Restart")
      systemctl reboot
      ;;
    "󰖔 Suspend")
      systemctl suspend
      ;;
    "󰑻 Hibernate")
      systemctl hibernate
      ;;
    "󰌾 Lock")
      swaylock
      ;;
    "󰗽 Log Out")
      if [[ "$DESKTOP_SESSION" == "hyprland" ]]; then
        hyprctl dispatch exit 1
      fi
      ;;
    esac
  fi
fi
