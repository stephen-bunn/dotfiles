#!/usr/bin/env sh

if !(command -v expressvpn > /dev/null 2>&1); then
    echo "expressvpn not found";
    exit 1;
fi

is_connected=$(expressvpn status);
if [ "$is_connected" = "Not connected" ]; then
    notify-send -t 2000 -- "Establishing connection to VPN";
    expressvpn connect smart;
else
    expressvpn disconnect;
fi

