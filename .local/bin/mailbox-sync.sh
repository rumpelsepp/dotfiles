#!/bin/bash

set -u

while true; do
    if [[ "$(nmcli network connectivity)" != "full" ]]; then
        sleep 5m
        continue
    fi

    mbsync -aq
    sleep 5m
done
