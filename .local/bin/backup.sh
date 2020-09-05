#!/bin/bash

set -eu

if (( "$EUID" != 0 )); then
    echo "Please run as root"
    exit 1
fi

subvol="$(btrbk run | grep -E "^\+{3} " | cut -c 5-)"
subvol_id="$(btrfs subvolume list / | grep "$subvol" | cut -d " " -f 2)"
tmpmount="/mnt/backup"

if [[ ! -d "$tmpmount" ]]; then
    mkdir "$tmpmount"
fi
chown rumpelsepp:rumpelsepp "$tmpmount"
mount -o subvolid="$subvol_id" /dev/mapper/lvm-root "$tmpmount"
trap 'umount "$tmpmount"' EXIT SIGTERM SIGINT

(
    cd "$tmpmount"

    restic_args=(
        --repo "sftp:cube.muc:backups/kronos"
        --password-command 'gopass show private/backups/restic/kronos'
        --verbose
        --exclude-caches
        --exclude "$tmpmount/go"
        --exclude "$tmpmount/b"
        --exclude "$tmpmount/.npm"
        --exclude "$tmpmount/.cache"
        --exclude "$tmpmount/.mozilla"
        --exclude "$tmpmount/.cargo/registry"
        --exclude "$tmpmount/.config/Code/Cache*"
        --exclude "$tmpmount/.config/Code/User"
        --exclude "$tmpmount/.local/share/Trash"
        --exclude "$tmpmount/.var"
        --exclude '*.o'
        --exclude '*.ko'
        --exclude '*.rlib'
        --exclude '*.lldb'
        "home/rumpelsepp"
    )

    sudo -u rumpelsepp restic backup "${restic_args[@]}"
)

