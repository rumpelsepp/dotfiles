#!/bin/bash

URL_REGEX='((?:https?:\/\/|ftp:\/\/|news:\/\/|git:\/\/|mailto:|file:\/\/|www\.)[\w\-\@;\/?:&=%\$_.+!*\x27(),~#\x1b\[\]]+[\w\-\@;\/?&=%\$_+!*\x27(~])'
TMUX_WINDOW_ID="9999"

tmux_open_inner_window() {
    tmux new-window -dn "" -t "$TMUX_WINDOW_ID"
    tmux setw -qt "$TMUX_WINDOW_ID" window-status-format ""
    tmux setw -qt "$TMUX_WINDOW_ID" window-status-current-format ""
}

main() {
    tmux capture-pane -eJ

    local buffer="$(tmux show-buffer)"
    matches=$(echo "$buffer" | grep -Po $URL_REGEX)
    if [[ $? != 0 ]]; then
        echo "error: no urls available"
        exit 1
    fi

    echo $matches
}

main
