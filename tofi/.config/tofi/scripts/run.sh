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
  if (ps -a | grep tofi-run >/dev/null); then
    killall -q tofi-run
  else
    tofi-run --config ~/.config/tofi/launcher_$theme | xargs hyprctl dispatch exec
  fi
fi
