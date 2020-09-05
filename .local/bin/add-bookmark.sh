#!/bin/bash

set -u

COMMIT='yes'

# $1: url
gettitle() {
    script="$(cat <<'EOF'
import sys
from bs4 import BeautifulSoup

data = sys.stdin.read()
soup = BeautifulSoup(data, 'html.parser')
print(soup.title.text)
EOF
)"
    curl -Ls "$1" | python -c "$script" | trimws.sed | sed -E "s/\[//;s/\]//"
}

title="$(gettitle "$1")"
if [[ "$?" != 0 ]]; then
    echo "gettitle() failed"
    COMMIT='no'
fi
line="* $(date +%F): [$title]($1)"

echo "$line"
sed -i --follow-symlinks "3 i $line" "$HOME/bookmarks.md"

if [[ "$COMMIT" != 'yes' ]]; then
    exit 1
fi

cd "$HOME/Projects/private/blog"
git commit -m "add $title" "./content/stuff/bookmarks.md"
git push
