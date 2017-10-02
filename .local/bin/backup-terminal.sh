#!/bin/bash

##############################################
# Config
##############################################

# Directory which should be backuped
SRC="/home/stefan"

# Borg repository; create with "borg init"
REPO="/run/user/1000/gvfs/smb-share:server=fileserver,share=home/tatschne/Backup"

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
##############################################

echo "Starting backup of ${SRC} to ${REPO}"
export BORG_PASSPHRASE="$(pass kronos/borg-terminal)"

borg create \
    --stats \
    --verbose \
    --progress \
    -C $COMPRESSION \
    --exclude "*/.atom" \
    --exclude "*/.cache" \
    --exclude "*/.ccache" \
    --exclude "*/*/cache" \
    --exclude "*/*/Cache" \
    --exclude "*/.local/share/Trash" \
    --exclude "*/.pyc" \
    --exclude "*/__pycache__" \
    --exclude "*/Steam" \
    --exclude "*/.wine" \
    --exclude "*/VirtualBox VMs" \
    "${REPO}::${ARCHIVE}" \
    "$SRC"

borg prune \
    --verbose \
    --keep-daily=$KEEP_DAILY \
    --keep-weekly=$KEEP_WEEKLY \
    --keep-monthly=$KEEP_MONTHLY \
    "${REPO}"

