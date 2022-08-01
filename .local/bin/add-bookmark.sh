#!/usr/bin/env bash

set -ue

COMMIT='yes'
REPO="$HOME/Projects/private/blog"
BOOKMARKFILE="$REPO/content/stuff/bookmarks.md"

# $1: url
gettitle() {
	local script
	script="$(
		cat <<'EOF'
import sys
from bs4 import BeautifulSoup

data = sys.stdin.read()
soup = BeautifulSoup(data, 'html.parser')
print(soup.title.text.strip().replace('\n', ''))
EOF
	)"
	curl -Ls "$1" | python -c "$script" | trimws.sed | sed -E "s/\[//;s/\]//"
}

process_url() {
	local title
	local line
	title="$(gettitle "$1")"
	line="* $(date +%F): [$title]($1)"

	echo "$line"
	sed -i --follow-symlinks "3 i $line" "$BOOKMARKFILE"

	if [[ "$COMMIT" != 'yes' ]]; then
		exit 1
	fi

	# cd "$REPO"
	# git commit -m "add $title" "$BOOKMARKFILE"
}

git -C "$REPO" pull --autostash --rebase

readarray -t lines

for line in "${lines[@]}"; do
	if [[ -z "$line" ]]; then
		continue
	fi
	process_url "$line"
done
