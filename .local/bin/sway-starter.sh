#!/bin/bash

DATADIR="$HOME/.local/share/sway-starter"
HISTFILE="$DATADIR/history.txt"

if [[ ! -d "$DATADIR" ]]; then
    mkdir -p "$DATADIR"
fi

if [[ ! -f "$HISTFILE" ]]; then
    touch "$HISTFILE"
fi

cmd=("$(compgen -c | sort -u | fzf --history "$HISTFILE" --no-extended --print-query | tail -n1)")
swaymsg -t command exec "systemd-cat -t ${cmd[0]} ${cmd[@]}"
