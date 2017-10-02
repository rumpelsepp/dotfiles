#!/bin/sh

SCREENDIR="/var/tmp/Screenshots"
SCREENFILE="${SCREENDIR}/Screenshot-$(date +'%F-%T').png"
LINKLATEST="${SCREENDIR}/latest"

[ ! -d "$SCREENDIR" ] && mkdir "$SCREENDIR"

sleep 0.5
maim -i $(xdotool getactivewindow) "$SCREENFILE"
ln -sf "$SCREENFILE" "$LINKLATEST"
