# kill script is updated to Version 2.0 with the help of pietryszak(github) idea
# script by phon31x & pietryszak
#! /bin/bash

u=$(xprop -name "Polybar tray window" _NET_WM_PID | grep -o '[[:digit:]]*')
kill $u
