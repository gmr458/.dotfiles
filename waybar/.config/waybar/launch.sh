#!/bin/bash

killall -q waybar
waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/style.css
