#!/bin/bash

if ! ping -c3 cube.muc > /dev/null; then
    echo "cube is not available!"
    exit 1
fi

# Setting this, so the repo does not need to be given on the commandline:
export RESTIC_REPOSITORY="sftp:cube.muc:backups/restic/kronos"

restic backup                                 \
    --password-command 'pass private/backups/restic/kronos' \
    --verbose \
    --exclude-caches                          \
    --exclude "$HOME/.cache"              \
    --exclude "$HOME/.mozilla"              \
    --exclude "$HOME/.cargo/registry"              \
    --exclude "$HOME/.config/Code/Cache*"      \
    --exclude "$HOME/.config/Code/User"      \
    --exclude "$HOME/.local/share/Trash"    \
    --exclude "$HOME/.var"                  \
    --exclude '*.o'                           \
    --exclude '*.ko'                          \
    --exclude '*.rlib'                        \
    --exclude '*.lldb'                        \
    $HOME

