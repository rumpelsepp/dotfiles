#!/bin/sh

SCRIPTNAME=$(basename "$0")
KEYWORDS="$1"
SUITE="testing"

usage() {
    echo "usage: $SCRIPTNAME [ARGS] [-h] KEYWORDS"
    echo ""
    echo "This script is a short wrapper over the search feature of the debian"
    echo "packages website: https://packages.debian.org/"
    echo "A new tab in a browser is opened using 'xdg-open' with an appropriate"
    echo "URL that starts an online search with the specified query."
    echo ""
    echo "arguments:"
    echo "  -s SUITE     Specify suite, e.g. \"stable\"; default \"testing\""
    echo "  -h           Show this page and exit"
}

while getopts "t:h" opt; do
    case $opt in
        s)  SUITE="$OPTARG";;
        h)  usage && exit 0;;
        *)  usage && exit 1;;
    esac
done

if [ "$#" -lt 1 ]; then
    usage
    exit 1
fi

# Not sure if I need this here.
shift $((OPTIND - 1))

xdg-open "https://packages.debian.org/search?keywords=${KEYWORDS}&searchon=names&suite=${SUITE}" > /dev/null
