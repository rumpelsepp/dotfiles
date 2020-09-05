#!/bin/bash

set -eu

cd "$HOME/Projects/private/blog"
git commit -m "commit bookmarks" "./content/stuff/bookmarks.md"
git push
