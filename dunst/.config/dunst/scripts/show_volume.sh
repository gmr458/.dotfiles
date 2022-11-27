#!/bin/bash

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F '/' '{print substr($2, 0, length($2)-2)}' | awk '{$1=$1;print}')
notify-send -t 600 "Volume" -h int:value:"${volume}"
