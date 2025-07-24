#!/bin/bash

volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | awk -F '/' '{print substr($2, 0, length($2)-2)}' | awk '{$1=$1;print}')
notify-send -t 600 "Microphone" -h int:value:"${volume}"
