#!/bin/bash

set -eu

if (( "$EUID" != 0 )); then
    echo "Please run as root"
    exit 1
fi

subvol="$(btrbk run | grep -E "^\+{3} " | cut -c 5-)"
subvol_id="$(btrfs subvolume list / | grep "$subvol" | cut -d " " -f 2)"
tmpmount="/mnt/backup"
prefix="/home/rumpelsepp"

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
        --exclude "$prefix/go"
        --exclude "$prefix/.npm"
        --exclude "$prefix/.cache"
        --exclude "$prefix/.mozilla"
        --exclude "$prefix/.cargo/registry"
        --exclude "$prefix/.config/Code/Cache*"
        --exclude "$prefix/.config/Code/User"
        --exclude "$prefix/.local/share/Trash"
        --exclude "$prefix/.var"
        --exclude '*.o'
        --exclude '*.ko'
        --exclude '*.rlib'
        --exclude '*.lldb'
        "home/rumpelsepp"
    )

    sudo -u rumpelsepp restic backup "${restic_args[@]}"

    if [[ -n "${AISEC-}" ]]; then
        restic_args=(
            --repo "sftp:steff@storage.pin.aisec.fraunhofer.de:backups/kronos"
            --password-command 'gopass show private/backups/restic/kronos'
            --verbose
            --exclude-caches
            --exclude "$prefix/go"
            --exclude "$prefix/.npm"
            --exclude "$prefix/.cache"
            --exclude "$prefix/.mozilla"
            --exclude "$prefix/.cargo/registry"
            --exclude "$prefix/.config/Code/Cache*"
            --exclude "$prefix/.config/Code/User"
            --exclude "$prefix/.local/share/Trash"
            --exclude "$prefix/.var"
            --exclude '*.o'
            --exclude '*.ko'
            --exclude '*.rlib'
            --exclude '*.lldb'
            "home/rumpelsepp"
        )

        sudo -u rumpelsepp restic backup "${restic_args[@]}"
    fi
)
