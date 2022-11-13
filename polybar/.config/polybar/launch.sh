#!/usr/bin/env bash

THEME="custom_catppuccin_mocha"

killall polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

CONFIG_DIR=$(dirname $0)/themes/$THEME/config.ini
polybar -r main -c $CONFIG_DIR &
