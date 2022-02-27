#!/usr/bin/env bash

set -eu

prefix="$HOME"

restic_args=(
	--repo "sftp://u160551@u160551.your-storagebox.de/backups/nodes"
	--password-command 'pass show backups/alderaan-storagebox'
	--verbose
	--one-file-system
	--exclude-caches
	--exclude "$prefix/go"
	--exclude "$prefix/.local/share/go"
	--exclude "$prefix/.npm"
	--exclude "$prefix/.cache"
	--exclude "$prefix/.mozilla"
	--exclude "$prefix/.cargo/registry"
	--exclude "$prefix/.config/Code/Cache*"
	--exclude "$prefix/.config/Code/User"
	--exclude "$prefix/.config/chromium"
	--exclude "$prefix/.local/share/Trash"
	--exclude "$prefix/.var"
	--exclude "$prefix/fuse"
	--exclude '*.o'
	--exclude '*.ko'
	--exclude '*.rlib'
	--exclude '*.lldb'
	"$prefix"
)

exec restic backup "${restic_args[@]}"
