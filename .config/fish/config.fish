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

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS="-F -g -i -M -R -S -w -X -z-4"
alias cal="ncal -b"

if which fzf > /dev/null
    fzf_key_bindings
end

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

