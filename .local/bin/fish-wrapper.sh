#!/bin/bash

# Since this is a bash script, it first sources
# all bash configs properly and then replaces
# itself with the magic fish.

source /etc/profile.d/vte-2.91.sh
exec fish
