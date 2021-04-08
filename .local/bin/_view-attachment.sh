#!/usr/bin/env bash

set -eu

FILE="$1"
ARTIFACTSDIR="/var/tmp/attachements"

echo "$FILE"

if [[ ! -d "$ARTIFACTSDIR" ]]; then
    mkdir -p "$ARTIFACTSDIR"
fi

cp "$FILE" "$ARTIFACTSDIR/"
gio open "$ARTIFACTSDIR/$(basename "$FILE")"
