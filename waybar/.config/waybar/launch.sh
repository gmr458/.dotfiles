#!/bin/bash

orientation=""
style=""
theme=""

help() {
  echo "script usage: $(basename $0) [-o vertical|horizontal] [-s style] [-t theme-name]" >&2
  echo "all options are mandatory"
  exit 1
}

while getopts ':o:s:t:?h' OPTION; do
  case "$OPTION" in
  o)
    if [[ $OPTARG = "vertical" || $OPTARG = "horizontal" ]]; then
      orientation=$OPTARG
    else
      orientation="horizontal"
    fi
    ;;
  s)
    style=$OPTARG
    ;;
  t)
    theme=$OPTARG
    ;;
  h|?)
    help
    ;;
  esac
done

if [[ -z $orientation || -z $style || -z $theme ]]; then
  help
else
  killall -q waybar
  waybar -c ~/.config/waybar/config/icons/$orientation/config.jsonc -s ~/.config/waybar/styles/$style/$theme/$orientation/style.css
fi

