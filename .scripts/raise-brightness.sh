#!/usr/bin/env sh

light -A 5;
brightness=$(light);
notify-send -h STRING:synchronous:brightness -t 500 -- "Brightness $brightness";

# pkill -SIGUSR1 herbe;
# herbe "Brightness $brightness";
