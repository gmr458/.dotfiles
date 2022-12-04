#!/bin/bash

theme=""

help() {
  echo "script usage: $(basename $0) [-t theme-name]" >&2
  exit 1
}

while getopts ':t:?h' OPTION; do
  case "$OPTION" in
  t)
    theme=$OPTARG
    ;;
  h | ?)
    help
    ;;
  esac
done

if [[ -z $theme ]]; then
  help
else
  if (ps -a | grep tofi-drun >/dev/null); then
    killall -q tofi-drun
  else
    tofi-drun --drun-launch=true --config ~/.config/tofi/launcher_$theme
  fi
fi
