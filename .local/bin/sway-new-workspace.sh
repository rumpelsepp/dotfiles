#!/bin/bash

set -eu
set -o pipefail

new_id=""
mapfile -t ids < <(swaymsg -t get_workspaces | jq ".[] | .num" | sort -un)

for ((i=1; i<=${#ids[@]}; i++)); do
    if [[ "$i" != "${ids[(($i-1))]}" ]]; then
        new_id="$i"
        break
    fi
done

if [[ -z "${new_id-}" ]]; then
    new_id=$((${#ids[@]} + 1))
fi

swaymsg "workspace $new_id"
