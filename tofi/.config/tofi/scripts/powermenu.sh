#!/bin/sh

if (ps -a | grep tofi >/dev/null); then
    killall -q tofi
else
	case $(printf "%s\n" "󰐥 Power Off" "󰑐 Restart" "󰖔 Suspend" "󰑻 Hibernate" "󰌾 Lock" "󰗽 Log Out" | tofi --config ~/.config/tofi/config_powermenu $@) in
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

