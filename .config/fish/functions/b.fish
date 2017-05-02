function b
    set -l BOOKMARKS_FILE "$HOME/.bookmarks"
    set -l tmpfile (mktemp)

    if test -r "$BOOKMARKS_FILE" 
        # fzf within () does not run interactively, see
        # https://github.com/fish-shell/fish-shell/issues/1362
        # Let's workaround that problem with a tmpfile.
        sed 's/#.*//g' < "$BOOKMARKS_FILE" | sed '/^\s*$/d' | fzf > $tmpfile
    end

    set -l destdir (cat $tmpfile)
    rm -f $tmpfile
    cd $destdir
end
