#!/usr/bin/env bash

REMOTE="pin-rpi4.aisec.fraunhofer.de"
REMOTE_PATH="htdocs/docs/pycan"
REMOTE_USER="stefan"

LOCAL_PATH="$HOME/Projects/IUNO/pycan/docs/_build/html/"

rsync -aPzz --stats --delete -e ssh "$LOCAL_PATH" "${REMOTE_USER}@${REMOTE}:${REMOTE_PATH}"
