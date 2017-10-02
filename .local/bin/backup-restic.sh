#!/usr/bin/env bash

##############################################
# Config
##############################################

#cleanup() {
#    sudo btrfs subvolume delete "$SNAPSHOT"
#}

#trap cleanup EXIT SIGTERM SIGINT

# Directory which should be backuped
SRC="/home/stefan"
#SNAPSHOT="$SRC/.snap/$(hostname)-$(pwgen -1)"

#sudo btrfs subvolume snapshot -r "$SRC" "$SNAPSHOT"

# Borg repository; create with "borg init"
export RESTIC_REPOSITORY="/run/media/stefan/bb672dbf-4fb8-4c34-9a5e-95e0486d14c2/restic"

# Prune settings
KEEP_DAILY=14
KEEP_WEEKLY=4
KEEP_MONTHLY=6
##############################################

export RESTIC_PASSWORD="$(pass kronos/restic)"

sudo -E restic backup \
    --exclude "*/.cache" \
    --exclude "*/.ccache" \
    --exclude "*/.local/share/Trash" \
    --exclude "*.pyc" \
    --exclude "*/__pycache__" \
    "$SRC"

# restic forget \
#    --verbose \
#    --keep-daily=$KEEP_DAILY \
#    --keep-weekly=$KEEP_WEEKLY \
#    --keep-monthly=$KEEP_MONTHLY \

