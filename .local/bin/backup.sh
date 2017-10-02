#!/usr/bin/env bash

##############################################
# Config
##############################################

# Directory which should be backuped
SRC="/home/stefan"

# Borg repository; create with "borg init"
REPO="/media/stefan/bb672dbf-4fb8-4c34-9a5e-95e0486d14c2/Backup"

# Backup archive within $REPO
# DO NOT SET TO A STATIC STRING!
ARCHIVE="home-$(hostname)-$(date +'%F %H%M%S %Z')"

# Compression; options available:
#   none             : no compression
#   lz4              : lz4
#   zlib             : zlib (default level 6)
#   zlib,0 .. zlib,9 : zlib (with level 0..9)
#   lzma             : lzma (default level 6)
#   lzma,0 .. lzma,9 : lzma (with level 0..9)
COMPRESSION="lz4"

# Prune settings
KEEP_DAILY=14
KEEP_WEEKLY=4
KEEP_MONTHLY=6
##############################################

echo "Starting backup of ${SRC} to ${REPO}"
export BORG_PASSPHRASE="$(pass kronos/borg)"

sudo -E borg create \
    --stats \
    --verbose \
    --progress \
    -C $COMPRESSION \
    --exclude "sh:*.cache" \
    --exclude "sh:*.ccache" \
    --exclude "sh:*.local/share/Trash" \
    --exclude "sh:*.pyc" \
    --exclude "sh:*__pycache__" \
    --exclude "sh:~/VirtualBox VMs" \
    "${REPO}::${ARCHIVE}" \
    "$SRC"

# borg prune \
#    --verbose \
#    --keep-daily=$KEEP_DAILY \
#    --keep-weekly=$KEEP_WEEKLY \
#    --keep-monthly=$KEEP_MONTHLY \
#    "${REPO}"

