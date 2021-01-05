function panewidget
    if test -z "$TMUX"
        commandline -f repaint
        return
    end
    set -l selection (fzf-tmux.sh)
    if test -z "$selection"
        commandline -f repaint
        return
    end

    commandline -t ""
    commandline -i -- "$selection"
    commandline -i -- " "
    commandline -f repaint
end

function fish_user_key_bindings
    bind \cf panewidget
end

