#!/usr/bin/env sh

pamixer --toggle-mute;
ou_mute=$(pamixer --get-mute);
pkill -SIGUSR1 herbe;

if [ $ou_mute = "true" ]; then
    notify-send -h STRING:synchronous:volume -t 500 -- "Audio Muted";
    # herbe "Audio Muted";
else
    notify-send -h STRING:synchronous:volume -t 500 -- "Audio Unmuted";
    # herbe "Audio Unmuted";
fi
