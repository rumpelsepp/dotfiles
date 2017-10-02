#!/bin/sh

sed '
    :a
    /^\n*$/ {
        $d
        N
        ba
    }

    s/[[:space:]]\+$//
' $@
