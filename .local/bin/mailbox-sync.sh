#!/bin/bash

set -eu

if [[ "$(nmcli network connectivity)" != "full" ]]; then
    exit 1
fi

if [[ "$1" == "-l" ]]; then
    while true; do
        mbsync -a
        sleep 5m
    done
else
    mbsync -a
fi
