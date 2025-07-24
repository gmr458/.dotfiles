#!/bin/bash

mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print tolower($0)}')

icon="󰕾"

if [[ $mute == "mute: yes" ]]; then
    icon="󰖁"
fi

notify-send -t 700 "${icon} Volume ${mute}"
