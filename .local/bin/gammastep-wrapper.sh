#!/usr/bin/env bash

set -eu

resp="$(curl -Ls https://ipapi.co/json)"
exec gammastep -l "$(jq ".latitude" <<< "$resp")":"$(jq ".longitude" <<< "$resp")" -m wayland
