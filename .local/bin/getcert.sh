#!/usr/bin/env bash

if (( $# < 2 )); then
    echo "usage: $(basename "$0") HOST PORT"
fi

openssl s_client -showcerts -servername "$1" -connect "$1:$2" < /dev/null
