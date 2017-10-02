#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP1 --off --output DP2-1 --mode 1920x1080 --pos 0x0 --rotate left --output DP2-2 --off --output DP2-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off
xrandr --output VIRTUAL1 --off --output eDP1 --mode 1920x1080 --pos 3000x728 --rotate normal --output DP1 --off --output DP2-1 --mode 1920x1080 --pos 0x0 --rotate left --output DP2-2 --primary --mode 1920x1080 --pos 1080x728 --rotate normal --output DP2-3 --off --output HDMI2 --off --output HDMI1 --off --output DP2 --off
~/.fehbg
i3 restart
