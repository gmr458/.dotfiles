#!/bin/bash

if pgrep -x tofi-run >/dev/null; then
  killall -q tofi-run
else
  cmd=$(tofi-run)
  if [[ -n "$cmd" ]]; then
    hyprctl dispatch exec "$cmd"
  fi
fi
