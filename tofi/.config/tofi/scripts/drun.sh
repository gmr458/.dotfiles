#!/bin/bash

if pgrep -x tofi-drun >/dev/null; then
  killall -q tofi-drun
else
  tofi-drun --drun-launch=true --width 320 --height 300
fi
