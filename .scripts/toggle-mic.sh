#!/usr/bin/env sh

if !(command -v pamixer > /dev/null 2>&1); then
    echo "pamixer not found";
    exit 1;
fi

pamixer --source 1 --toggle-mute;
is_muted=$(pamixer --source 1 --get-mute);

mute_state="Unmuted";
if [ $is_muted = "true" ]; then
    mute_state="Muted";
fi

notify-send -h STRING:synchronous:volume -t 500 -- "Microphone $mute_state";

