#!/bin/bash

set -e

if pidof swaylock > /dev/null; then
    echo "error: already locked?"
    exit 1
fi

cleanup() {
    kill %%
}

swayidle timeout 10 'swaymsg "output * dpms off"' \
         resume 'swaymsg "output * dpms on"' &

# Be sure to kill swayidle.
trap 'cleanup' SIGINT SIGTERM QUIT

swaylock
kill %%
