#!/usr/bin/env sh

# set background imgae
feh --bg-scale /usr/share/backgrounds/1588030864793.jpg

# set keyboard read rate
xset r rate 200 40

# background services
slstatus &
xcompmgr &
sxhkd &
dunst &

