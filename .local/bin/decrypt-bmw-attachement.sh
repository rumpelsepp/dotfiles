#!/bin/bash

set -eu

file="$1"
name="$(gpg --list-packets "$file" | grep -oP 'name="(.+)"' | grep -Po '".*"' | sed 's/"//g')"
echo "THE FILENAME IS: $name"
gpg -o "$name" --decrypt "$file"
