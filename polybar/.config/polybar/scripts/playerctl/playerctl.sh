#!/bin/bash

playerctl_status=$(playerctl status 2> /dev/null)

if [[ $playerctl_status == "Playing" ]]; then
    echo "%{A1:playerctl pause:}󰏤%{A}󰎇 "
elif [[ $playerctl_status == "Paused" ]]; then
    echo "%{A1:playerctl play:}󰐊%{A}󰎇 "
else
    echo ""
fi
