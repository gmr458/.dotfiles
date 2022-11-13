#!/bin/bash

if (ps -a | grep wofi >/dev/null); then
    killall -q wofi
else
    wofi --show run
fi
