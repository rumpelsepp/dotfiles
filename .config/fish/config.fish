# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status --is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status --is-interactive
#   ...
# end

if status --is-interactive
    export TERMINAL="gnome-terminal"
    export EDITOR="nvim"
    export PAGER="less"
    export MANWIDTH="80"
    export MANOPT="--nj --nh"
    export MANPAGER="nvim -c 'set ft=man' -"

    # Set the default Less options.
    # Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
    # Remove -X and -F (exit if the content fits on one screen) to enable it.
    export LESS="-F -g -i -M -R -S -w -X -z-4"
    alias cal="ncal -b"
    alias e='env TERM=xterm-256color emacsclient -t'
    alias emacs='env TERM=xterm-256color emacs'

    function __fish_set_oldpwd --on-variable dirprev
        set -g OLDPWD $dirprev[-1]
    end

    function __fish_set_gitroot --on-variable PWD
        set -g GITROOT (git rev-parse --show-toplevel 2> /dev/null)
    end

    function fish_greeting
    end

    function now
        date +%F_%T
    end
end
