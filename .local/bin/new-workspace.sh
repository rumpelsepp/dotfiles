#!/bin/sh

# https://faq.i3wm.org/question/6004/creating-a-new-workspace.1.html
i3-msg workspace $(($(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d : -f 2 | sort -rn | head -1) + 1))
