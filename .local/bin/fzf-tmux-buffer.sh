#!/usr/bin/env bash

set -eu

fzf_flags=(
    "-d" "35%"
    "--multi"
    "--exit-0"
    "--cycle"
    "--reverse"
    "--bind=ctrl-r:toggle-all"
    "--bind=ctrl-s:toggle-sort"
    "--no-preview"
)

lines="$(tmux capture-pane -pJ | sed '/^\s*$/d' | sort -ur)"
selection="$(fzf-tmux -p -- "${fzf_flags[@]}" <<< "$lines" | sed -E 's/^\s+|\s+$//g' | tr -d "\n")"
echo "$selection"
