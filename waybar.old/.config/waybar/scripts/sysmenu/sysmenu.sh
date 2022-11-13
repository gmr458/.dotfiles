#!/bin/bash

confirm() {
	answer=$(printf "Yes\nNo" | wofi --dmenu --insensitive --conf ~/.config/wofi/confirm --style ~/.config/wofi/confirm.css)
	echo $answer
}

if (ps -a | grep wofi >/dev/null); then
	killall -q wofi
else
	chosen=$(printf "󰐥 Power Off\n󰑐 Restart\n󰌾 Lock\n󰗽 Logout" | wofi --dmenu --insensitive --conf ~/.config/wofi/powermenu --style ~/.config/wofi/powermenu.css)

	case "$chosen" in
	"󰐥 Power Off")
		answer=$(confirm &)
		if [[ $answer == "Yes" ]]; then
			systemctl poweroff
		elif [[ $answer == "No" ]]; then
			exit 0
		else
			echo "Aborted systemctl poweroff"
		fi
		;;
	"󰑐 Restart")
		answer=$(confirm &)
		if [[ $answer == "Yes" ]]; then
			systemctl reboot
		elif [[ $answer == "No" ]]; then
			exit 0
		else
			echo "Aborted systemctl reboot"
		fi
		;;
	"󰌾 Lock")
		answer=$(confirm &)
		if [[ $answer == "Yes" ]]; then
			swaylock
		elif [[ $answer == "No" ]]; then
			exit 0
		else
			echo "Aborted swaylock"
		fi
		;;
	"󰗽 Logout")
		answer=$(confirm &)
		if [[ $answer == "Yes" ]]; then
			echo "Logout"
		elif [[ $answer == "No" ]]; then
			exit 0
		else
			echo "Aborted logout"
		fi
		;;
	*) exit 1 ;;
	esac
fi
