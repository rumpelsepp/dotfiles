#!/bin/bash

set -e

SCREENDIR="$HOME/Pictures/screenshots"
SCREENFILE="${SCREENDIR}/screenshot-$(date +'%F-%T').png"
LINKLATEST="${SCREENDIR}/latest"

usage() {
    echo "usage: $(basename $0) [-sch]"
    echo ""
    echo "options:"
    echo " -c   capture current workspace"
    echo " -s   select capture area"
    echo " -h   show help"
}

current_output() {
    swaymsg -t get_outputs | jq -r '.[] | select(.focused == true) | .name'
}

if [[ ! -d "$SCREENDIR" ]]; then
    mkdir -p "$SCREENDIR"
fi

while getopts "csh" arg; do
    case "$arg" in
        s)  grim -g "$(slurp)" "$SCREENFILE";;
        c)  grim -o "$(current_output)" "$SCREENFILE";;
        h)  usage && exit 0;;
        *)  usage && exit 1;;
    esac
done

if (( $# < 1 )); then
    usage
    exit 1
fi

ln -sf "$SCREENFILE" "$LINKLATEST"
