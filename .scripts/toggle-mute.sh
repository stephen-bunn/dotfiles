#!/usr/bin/env sh

if !(command -v pamixer > /dev/null 2>&1); then
    echo "pamixer not found";
    exit 1;
fi

pamixer --toggle-mute;
is_muted=$(pamixer --get-mute);

mute_state="Unmuted";
if [ $is_muted = "true" ]; then
    mute_state="Muted";
fi

notify-send -h STRING:synchronous:volume -t 500 -- "Audio $mute_state";

