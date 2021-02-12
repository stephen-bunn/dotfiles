#!/usr/bin/env sh

input=$(dmenu -p "Run");
if [ -z $input ]; then
    exit 1;
fi

exec $input;

