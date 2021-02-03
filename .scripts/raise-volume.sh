#!/usr/bin/env sh

pamixer -i 5;
ou_vol=$(pamixer --get-volume);
ou_mute=$(pamixer --get-mute);
pkill -SIGUSR1 herbe;

if [ $ou_mute = "false" ]; then
    notify-send -h STRING:synchronous:volume -t 500 -- "Volume $ou_vol";
    # herbe "Output Volume $ou_vol";
fi
