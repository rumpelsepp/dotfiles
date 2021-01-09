#!/bin/bash

set -eu

BOOKMARKS="./content/stuff/bookmarks.md"

cd "$HOME/Projects/private/blog"

s="$(git status --porcelain "$BOOKMARKS")"
if [[ -n "$s" ]]; then
    git commit -m "commit bookmarks" "$BOOKMARKS"
fi
git push
