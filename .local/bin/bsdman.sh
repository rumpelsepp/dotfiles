#!/bin/sh
# stolen from https://bitbucket.org/ambrevar/dotfiles/raw/ab1a558086d042db86f32c6fa87fa68c7296518d/.scripts/bsdman

pager="${MANPAGER:-${PAGER:-less}}"

if [ "${0##*/}" = "obsdman" ]; then
	OS=OpenBSD
	DOMAIN="http://www.openbsd.org/cgi-bin"
	MANPATH="OpenBSD+Current"
else
	OS=FreeBSD
	DOMAIN="http://www.freebsd.org/cgi"
	MANPATH="FreeBSD+11.1-RELEASE+and+Ports"
fi

if [ $# -eq 0 ] || [ "$1" = "-h" ]; then
	cat<<EOF
Usage: ${0##*/} [SECTION] PAGE

Fetch $OS man page PAGE from the official website and display it.

EOF
	exit
fi

SECTION=0
PAGE=$1
if [ $# -eq 2 ]; then
	SECTION="$1"
	PAGE="$2"
fi

curl -sL "$DOMAIN/man.cgi?query=$PAGE&apropos=0&sektion=$SECTION&manpath=$MANPATH&arch=default&format=ascii" | eval "$pager"
