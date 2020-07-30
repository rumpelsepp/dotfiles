#!/bin/bash

exec restic \
    --repo "sftp:cube.muc:backups/restic/kronos" \
    --password-command 'pass private/backups/restic/kronos' \
    "$@"
