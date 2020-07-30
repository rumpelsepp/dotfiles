#!/usr/bin/env bash

set -eu
set -o pipefail

jq_prog='recurse(.nodes[]) |
         if has("window_properties") then
             [.id, .window_properties.class, .window_properties.title] | join(": ")
         elif has("app_id") then
             [.id, .app_id, .name] | join(": ")
         else
             empty
         end'

selection="$(swaymsg -t get_tree | jq -r "$jq_prog" | fzf -d : --with-nth 2..-1 | cut -d: -f1)"
swaymsg "[con_id=$selection]" focus
