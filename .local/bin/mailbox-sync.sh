#!/bin/bash

set -e

PRIMARY_EMAIL=$(notmuch config get user.primary_email)
readarray -t OTHER_EMAIL <<< $(notmuch config get user.other_email)

syncronize() {
    mbsync private
    notmuch new

    notmuch tag +inbox -- folder:INBOX
    notmuch tag -inbox -- not folder:INBOX

    notmuch tag +inbox -- folder:INBOX to:$PRIMARY_EMAIL

    for mail in "${OTHER_EMAIL[@]}"; do
        notmuch tag +inbox -- folder:INBOX to:$mail
    done
}

if ! nmcli networking connectivity > /dev/null; then
    exit 1
fi

if [[ $1 == '-k' ]]; then
    while true; do
        syncronize
        sleep 15m
    done
else
    syncronize
fi
