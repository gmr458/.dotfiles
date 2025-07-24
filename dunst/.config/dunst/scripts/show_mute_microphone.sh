#!/bin/bash

mute=$(pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print tolower($0)}')

icon="󰍬"

if [[ $mute == "mute: yes" ]]; then
    icon="󰍭"
fi

notify-send -t 700 "${icon} Microphone ${mute}"
