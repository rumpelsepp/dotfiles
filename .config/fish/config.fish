# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status --is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status --is-interactive
#   ...
# end

if not status --is-interactive
    exit 0
end

function fish_greeting
end

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS="-F -g -i -M -R -S -w -X -z-4"

if which fzf > /dev/null
    fzf_key_bindings
end

function __fish_set_oldpwd --on-variable dirprev
    set -g OLDPWD $dirprev[-1]
end

function __fish_set_gitroot --on-variable PWD
    set -g GITROOT (git rev-parse --show-toplevel 2> /dev/null)
end

function sudobangbang --on-event fish_postexec
    abbr !! sudo $argv[1]
end

alias now "date +%F_%T"
alias hd "hexdump -C"
alias mutt "neomutt"
alias pacman "yay"
alias ssh "env TERM=xterm-256color ssh"
# alias tmux "tmux -f ~/.config/tmux/tmux.conf"

bind --key btab __fzf_complete
