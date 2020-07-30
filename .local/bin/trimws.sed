#!/bin/sed -f

:a
/^\n*$/ {
    $d
    N
    ba
}

s/[[:space:]]\+$//
