#!/usr/bin/env bash

THEME="custom_catppuccin_mocha"

CONFIG_DIR=$(dirname $0)/themes/$THEME/config.ini
polybar -r tray -c $CONFIG_DIR &
