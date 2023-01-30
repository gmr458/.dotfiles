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
  if (ps -a | grep tofi-drun >/dev/null); then
    killall -q tofi-drun
  else
    tofi-drun --drun-launch=true --config ~/.config/tofi/launchers/$border/$theme/launcher
  fi
fi
