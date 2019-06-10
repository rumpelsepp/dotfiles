#!/bin/bash

EDITOR="${EDITOR:-nano}"
LOGDIR="${LOGDIR:-$PWD}"
HUMAN_READABLE='n'
SKIP_MANIFEST='n'
COMMIT='n'
GZIP_LOG='n'

genfilename() {
    local i_max=0

    for file in "$LOGDIR"/*.log; do
        if [[ "$file" =~ ^$LOGDIR/([0-9]{4})\.log$ ]]; then
            i=10#${BASH_REMATCH[1]}
            if (( i > i_max )); then
                i_max=$i
            fi
        fi
    done

    printf "$LOGDIR"/%04d.log $((i_max + 1))
}

usage() {
    echo "usage: $(basename "$BASH_ARGV0") [-n] [-h]"
    echo ''
    echo 'options:'
    echo ' -c            Commit results after a testrun'
    echo ' -r            Human readable converter; pipes JSON output through "hr"'
    echo ' -s            Skip manifest foo'
    echo ' -z            Compress archived logfile with gzip'
    echo ' -n DIRNAME    Create new testrun dir'
    echo ' -h            Show this page and exit'
}

git_commit_changes() {
    if [[ "$COMMIT" == 'y' ]]; then
        git add "$1"
        git commit -v
    fi
}

# $1: dirname to create
newtestrundir() {
    local tempfile
    local pattern='^[0-9a-zA-Z]+$'

    if [[ ! "$1" =~ $pattern ]]; then
        echo "error: dir '$1' is invalid; must match '$pattern', Luke."
        exit 1
    fi

    if [[ -d "$1" ]]; then
        echo "error: dir '$1' exists"
        exit 1
    fi

    tempfile="$(mktemp)"
    trap '[[ -e $tempfile ]] && rm $tempfile' SIGINT SIGTERM EXIT

    cat << EOF > "$tempfile"
date    : $(date)
purpose : <What do you intend to do?>
testruns: |This will be created automatically. No task for you, Luke.|
EOF

    $EDITOR "$tempfile"

    if grep -E '<|>' "$tempfile" > /dev/null; then
        echo "You fool. Fill in the porpose and delete the <>!!"
        exit 1
    fi

    mkdir -pv "$1"
    sed -i 's/|.*|//g' "$tempfile"
    mv "$tempfile" "$1/MANIFEST"

    git_commit_changes "$1"
}

main() {
    local comment
    local filename
    local manifest="$LOGDIR/MANIFEST"
    filename="$(genfilename)"

    if [[ "$SKIP_MANIFEST" == 'n' ]]; then
        if [[ -e "$manifest" ]]; then
            read -r -p "add an (optional) comment to $manifest: "  comment

            if [[ -n "$comment" ]]; then
                echo "  - $(date): $(basename "$filename")   $comment" >> "$manifest"
            else
                echo "  - $(date): $(basename "$filename")" >> "$manifest"
            fi
        else
            echo "warning: $manifest does not exist. Are you flooding the wrong directory?"
            echo "hint: set '\$LOGDIR' to you desired location"
            echo "continue?"
            select yn in "Yes" "No"; do
                case "$yn" in
                    No)     exit 1;;
                    Yes)    break;;
                esac
            done
        fi
    fi

    echo "Archiving to: $filename"

    if [[ "$HUMAN_READABLE" == 'y' ]]; then
        "$@" |& tee "$filename" | hr
    else
        "$@" |& tee "$filename"
    fi

    if [[ "$GZIP_LOG" == 'y' ]]; then
        gzip "$filename"
    fi

    git_commit_changes "$LOGDIR"
}

while getopts "cn:rszh" arg; do
    case "$arg" in
        c)  COMMIT='y';;
        n)  newtestrundir "$OPTARG"; exit $?;;
        r)  HUMAN_READABLE='y';;
        s)  SKIP_MANIFEST='y';;
        z)  GZIP_LOG='y';;
        h)  usage && exit 0;;
        *)  usage && exit 1;;
    esac
done

shift $((OPTIND - 1))

# We actually want to see logs in realtime rather than each 4kB block.
export PYTHONUNBUFFERED=y

main "$@"
