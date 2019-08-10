#!/usr/bin/bash

FZF_FLAGS=(
    "-d 35%"
    "--multi"
    "--exit-0"
    "--cycle"
    "--reverse"
    --bind='ctrl-r:toggle-all'
    --bind='ctrl-s:toggle-sort'
    "--no-preview"
)

content="$(tmux capture-pane -J -p)"
urls=($(echo "$content" | grep -oE '(https?|ftp|file):/?//[-A-Za-z0-9+&@#/%?=~_|!:,.;]*[-A-Za-z0-9+&@#/%=~_|]'))
wwws=($(echo "$content" | grep -oE 'www\.[a-zA-Z](-?[a-zA-Z0-9])+\.[a-zA-Z]{2,}(/\S+)*'))
ips=($(echo  "$content" | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}(:[0-9]{1,5})?(/\S+)*'))
gits=($(echo "$content" | grep -oE '(ssh://)?git@\S*' | sed 's/:/\//g' | sed 's/^\(ssh\/\/\/\)\{0,1\}git@\(.*\)$/https:\/\/\2/'))

merge() {
    for item in "$@" ; do
        echo "$item"
    done
}

merge "${urls[@]}" "${wwws[@]}" "${ips[@]}" "${gits[@]}" |
    sort -u |
    nl -w3 -s '  ' |
    fzf-tmux "${FZF_FLAGS[@]}" |
    awk '{printf "%s", $2}' | wl-copy
