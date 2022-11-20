#!/bin/bash

killall polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

CONFIG=$(dirname $0)/config.ini
polybar -r main -c $CONFIG &
