#!/bin/bash

if (ps -a | grep tofi-run >/dev/null); then
  killall -q tofi-run
else
  tofi-run | xargs hyprctl dispatch exec
fi
