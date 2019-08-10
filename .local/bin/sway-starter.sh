#!/bin/bash

set -e

# From flock manpage. Allow only one instance of this script.
[ "${FLOCKER}" != "$0" ] && exec env FLOCKER="$0" flock -en "$0" "$0" "$@"

DATADIR="$HOME/.local/share/sway-starter"
HISTFILE="$DATADIR/history.txt"

if [[ ! -d "$DATADIR" ]]; then
    mkdir -p "$DATADIR"
fi

if [[ ! -f "$HISTFILE" ]]; then
    touch "$HISTFILE"
fi

cmd=("$(compgen -c | sort -u | fzf --history "$HISTFILE" --no-extended --print-query | tail -n1)")

if [[ -z "${cmd[@]}" ]]; then
    exit 1
fi

swaymsg -t command exec "systemd-cat -t ${cmd[0]} ${cmd[@]}"
