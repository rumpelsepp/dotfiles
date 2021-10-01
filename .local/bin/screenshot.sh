#!/usr/bin/env bash

set -eu

notify=0

# $1: screendir
usage() {
    local screendir
    screendir="$1"

    echo "usage: $(basename "$BASH_ARGV0") [OPTIONS] [COMMAND]"
    echo ""
    echo "commands:"
    echo " -a   select capture area"
    echo " -o   capture current output"
    echo " -s   capture whole screen"
    echo " -w   capture current window"
    echo " -W   select a window"
    echo " -h   show help"
    echo ""
    echo "options:"
    echo " -d   screenshot directory (default: $screendir)"
    echo " -c   copy image to clipboard"
    echo " -n   send a notification"
}

current_output() {
    swaymsg -t get_outputs | jq -r '.[] | select(.focused == true) | .name'
}

current_window() {
    local geometry
    local json

    json="$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.focused)')"
    geometry="$(jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"' <<< "$json")"

    echo "$geometry"
}

select_window() {
    local geometry
  geometry=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)

  if [[ "$geometry" == "" ]]; then
      return 1
  fi

  echo "$geometry"
}

notify() {
    notify-send -t 3000 -a screenshot.sh screenshot.sh "$@"
}

# $1: output name
# $2: output file
capture_output() {
    if [[ "$2" == "-" ]]; then
        grim -o "$1" "$2" | wl-copy --type image/png
    else
        grim -o "$1" "$2"
    fi
}

# $1: geometry
# $2: output file
capture_area() {
    if [[ "$2" == "-" ]]; then
        grim -g "$1" "$2" | wl-copy --type image/png
    else
        grim -g "$1" "$2"
    fi
}

# $1: output file
capture_screen() {
    if [[ "$1" == "-" ]]; then
        grim "$1" | wl-copy --type image/png
    else
        grim "$1"
    fi
}

exit_handler() {
    local error_code="$?"

    if (( error_code == 0 )); then
        return
    fi

    msg="Taking screenshot failed! Please investigate."
    if (( notify )); then
        notify "$msg"
    else
        echo "$msg"
    fi
}

main() {
    local screendir
    local screenfilename
    local screenfile
    local linklatest

    screendir="$HOME/Pictures/screenshots"

    local cmd=""
    local clipboard=0

    trap exit_handler EXIT

    while getopts "aoswWhd:cn" arg; do
        case "$arg" in
            d)  screendir="$OPTARG";;
            c)  clipboard=1;;
            n)  notify=1;;

            a)  cmd="area";;
            o)  cmd="output";;
            s)  cmd="screen";;
            w)  cmd="window";;
            W)  cmd="window-select";;
            h)  usage "$screendir" && exit 0;;
            *)  usage "$screendir" && exit 1;;
        esac
    done

    if [[ "$cmd" == "" ]]; then
        echo "No command specified!"
        exit 1
    fi

    screenfilename="screenshot-$(date +'%F_%Hh%Mm%Ss').png"
    screenfile="${screendir}/${screenfilename}"
    linklatest="${screendir}/latest.png"

    if (( clipboard )); then
        screenfile="-"
    elif [[ ! -d "$screendir" ]]; then
        mkdir -p "$screendir"
    fi

    case "$cmd" in
        area) capture_area "$(slurp)" "$screenfile";;
        output) capture_output "$(current_output)" "$screenfile";;
        screen) capture_screen "$screenfile";;
        window) capture_area "$(current_window)" "$screenfile";;
        window-select) capture_area "$(select_window)" "$screenfile";;
        *) echo "unknown command"; exit 1;;
    esac

    if (( ! clipboard )); then
        ln -f "$screenfile" "$linklatest"
    fi

    if (( notify )); then
        if (( clipboard )); then
            notify "Screenshot captured. Available in clipboard."
        else
            notify "Screenshot captured: $screenfile"
        fi
    fi
}

main "$@"
