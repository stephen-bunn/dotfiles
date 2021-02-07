#!/usr/bin/env sh

FIGLET_FONT="$HOME/.fonts/figlet-fonts/contributed/fraktur.flf"

if !(command -v slock > /dev/null 2>&1); then
    echo "slock not found";
    exit 1;
fi

if !(command -v figlet > /dev/null 2>&1); then
    echo "figlet not found";
    exit 1;
fi

timestamp=$(date '+%a %d, %H:%M:%S');
title=$(figlet -f "$FIGLET_FONT" 'Locked');
slock -m "$title
Locked $timestamp";

