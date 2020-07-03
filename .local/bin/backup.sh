#!/bin/bash

# Setting this, so the repo does not need to be given on the commandline:
export RESTIC_REPOSITORY="sftp:u160551@u160551.your-storagebox.de:backups/kronos"
# export RESTIC_REPOSITORY="/run/user/1000/gvfs/smb-share:server=storage.sevenbyte.org,share=backup/backups/kronos"

exec restic backup                                 \
    --password-command 'pass private/backups/restic/kronos' \
    --verbose \
    --exclude-caches                          \
    --exclude "$HOME/.npm"              \
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

