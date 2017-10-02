#!/bin/sh

if [ -z "$1" ]; then
    i3-msg move workspace to output left
else
    i3-msg move workspace to output $1
fi
