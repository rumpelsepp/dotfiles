#!/bin/bash

set -u
set -o pipefail

choose() {
    for app in "$@"; do
        echo "$app"
    done | fzf
}

get_desktop_files() {
    local path
    path="$1"
    if [[ ! -d "$path" ]]; then
        return 1
    fi
    for f in "$path"/*.desktop; do
        filename="$(basename "$f")"
        echo "${filename%.desktop}"
    done
}

# From flock manpage. Allow only one instance of this script.
if [[ "${FLOCKER-}" != "$0" ]]; then
    FLOCKER="$0" exec flock -en "$0" "$0" "$@"
fi

apps=()
apps+=("$(get_desktop_files "/usr/share/applications")")
apps+=("$(get_desktop_files "/var/lib/flatpak/exports/share/applications")")
apps+=("$(get_desktop_files "$HOME/.local/share/flatpak/exports/share/applications")")

IFS=$'\n' mapfile -t apps < <(sort <<<"${apps[*]}")
unset IFS

choice="$(choose "${apps[@]}")"
swaymsg -t command exec "systemd-cat -t $choice gtk-launch $choice"
