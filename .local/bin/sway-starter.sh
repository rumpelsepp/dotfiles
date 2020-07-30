#!/bin/bash

set -eu
set -o pipefail

# From flock manpage. Allow only one instance of this script.
if [[ "${FLOCKER-}" != "$0" ]]; then
    FLOCKER="$0" exec flock -en "$0" "$0" "$@"
fi

cmd=("$(compgen -c | sort -u | fzf --no-extended --print-query | tail -n1)")
swaymsg -t command exec "systemd-cat -t ${cmd[0]} ${cmd[*]}"
