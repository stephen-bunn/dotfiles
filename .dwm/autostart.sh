#!/usr/bin/env sh

# set background imgae
feh --bg-fill /usr/share/backgrounds/wallpaper.jpg

# set keyboard read rate
xset r rate 200 40

# background services
slstatus &
xcompmgr &
sxhkd &
dunst &
xautolock -time 15 -locker $HOME/.scripts/lock.sh -notify 60 -notifier 'notify-send -t 5000 -- "Locking screen in 1 minute"' &

