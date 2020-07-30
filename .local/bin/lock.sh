#!/bin/bash

set -eu

if pidof swaylock > /dev/null; then
    echo "error: already locked?"
    exit 1
fi

cleanup() {
    kill %%
    wait
}

swayidle timeout 10 'swaymsg "output * dpms off"' \
         resume 'swaymsg "output * dpms on"' &

# Be sure to kill swayidle.
trap 'cleanup' SIGINT SIGTERM QUIT EXIT

swaylock
