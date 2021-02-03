#!/usr/bin/env sh

pamixer --source 1 --toggle-mute;
ou_mute=$(pamixer --source 1 --get-mute);
pkill -SIGUSR1 herbe;

if [ $ou_mute = "true" ]; then
    notify-send -h STRING:synchronous:volume -t 500 -- "Microphone Muted";
    # herbe "Audio Muted";
else
    notify-send -h STRING:synchronous:volume -t 500 -- "Microphone Unmuted";
    # herbe "Audio Unmuted";
fi
