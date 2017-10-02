#!/usr/bin/env bash

##############################################
# Config
##############################################

# Directory which should be backuped
SRC="/home/stefan"

# Borg repository; create with "borg init"
REPO="stefan@romulus.aisec.fraunhofer.de:/mnt/Backup/kronos"

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
export BORG_PASSPHRASE="$(pass romulus/borg)"

borg create \
    --stats \
    --verbose \
    --progress \
    -C $COMPRESSION \
    --exclude "$SRC/*.cache" \
    --exclude "$SRC/*.ccache" \
    --exclude "$SRC/*.local/share/Trash" \
    --exclude "$SRC/*.pyc" \
    --exclude "/**/*__pycache__" \
    "${REPO}::${ARCHIVE}" \
    "$SRC"

# borg prune \
#    --verbose \
#    --keep-daily=$KEEP_DAILY \
#    --keep-weekly=$KEEP_WEEKLY \
#    --keep-monthly=$KEEP_MONTHLY \
#    "${REPO}"
