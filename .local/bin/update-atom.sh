#!/usr/bin/env bash
#
# The MIT License (MIT)
#
# Copyright (c) 2017 Stefan Tatschner
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

set -e
set -o noglob

GITHUB_API="https://api.github.com"
ATOM_PACKAGE_NAME="atom"

usage() {
    echo "usage: $0 [--beta] [-h | --help]"
    exit 1
}

atom_version() {
    dpkg-query --showformat='${Version}\n' --show "$ATOM_PACKAGE_NAME"
}

atom_is_installed() {
    dpkg -s "$ATOM_PACKAGE_NAME" &> /dev/null
}

atom_download_and_install() {
    local filename
    local tmpdir

    filename="$(basename "$download_url")"
    tmpdir=$(mktemp -d)

    # shellcheck disable=SC2064
    trap "cd /; rm -rf $tmpdir;" EXIT TERM INT

    cd "$tmpdir"

    curl -L -o "$filename" "$1"
    sudo apt install "./$filename"
}

if [[ $# == 0 ]]; then
    api_path="repos/atom/atom/releases/latest"
    jq_filter="."
elif [[ $1 == "--beta" ]]; then
    ATOM_PACKAGE_NAME="atom-beta"
    api_path="repos/atom/atom/releases"
    jq_filter=".[0] | select(.prerelease)"
elif [[ $1 == "--help" || $1 == "-h" ]]; then
    usage
else
    usage
fi

json="$(curl -Ls $GITHUB_API/$api_path | jq "$jq_filter")"
download_url="$(echo "$json" | jq '.assets[] | select(.content_type == "application/x-debian-package") | .browser_download_url' | sed 's/\"//g')"
remote_version="$(echo "$json" | jq '.tag_name' | sed -e 's/\"//g' -e 's/^v//')"
local_version=$(atom_version)

if atom_is_installed; then
    if [[ "$local_version" == "$remote_version" ]]; then
        echo "$ATOM_PACKAGE_NAME is up to date!"
        exit 0
    fi
fi

atom_download_and_install "$download_url"
