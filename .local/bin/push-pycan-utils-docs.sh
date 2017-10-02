#!/usr/bin/env bash

REMOTE="pin-rpi4.aisec.fraunhofer.de"
REMOTE_PATH="htdocs/pycan-utils-docs"
REMOTE_USER="stefan"

LOCAL_PATH="$HOME/Projects/IUNO/pycan-utils/docs/"

rsync -aPzz --stats --delete -e ssh "$LOCAL_PATH" "${REMOTE_USER}@${REMOTE}:${REMOTE_PATH}"
