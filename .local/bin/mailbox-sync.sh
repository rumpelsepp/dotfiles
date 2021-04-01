#!/bin/bash

set -eu

if [[ "$(nmcli network connectivity)" != "full" ]]; then
    exit 1
fi

mbsync -a
