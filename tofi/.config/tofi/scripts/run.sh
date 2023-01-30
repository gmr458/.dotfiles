#!/bin/bash

border=""
theme=""

help() {
  echo "script usage: $(basename $0) [-t theme-name]" >&2
  exit 1
}

while getopts ':b:t:?h' OPTION; do
  case "$OPTION" in
  b)
    border=$OPTARG
    ;;
  t)
    theme=$OPTARG
    ;;
  h | ?)
    help
    ;;
  esac
done

if [[ -z border || -z $theme ]]; then
  help
else
  if (ps -a | grep tofi-run >/dev/null); then
    killall -q tofi-run
  else
    tofi-run --config ~/.config/tofi/launchers/$border/$theme/launcher | xargs hyprctl dispatch exec
  fi
fi
