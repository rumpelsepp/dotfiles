#!/usr/bin/env bash

if ! dpkg -s zutils &> /dev/null; then
    echo "Please install package zutils"
    echo "  # apt install zutils"
    exit 1
fi

filepath=$(man -w $1)

if [[ -z "$filepath" ]]; then
    echo "manpage not found"
    exit 1
fi

shift

zcat "$filepath" | mandoc $@
