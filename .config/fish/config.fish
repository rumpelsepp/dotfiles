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

function fish_mode_prompt
end

function fish_command_not_found
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

# Workaround for foot until terminfo is in upstream
# ncurses like kitty and alacritty. Will eventually
# happen but take some time.
if echo "$TERM" | string match "foot" > /dev/null
    alias ssh "TERM=xterm-256color command ssh"
end

alias ip "ip --color=auto"
alias now "date +%F_%T"
alias now-raw "date +%Y%m%d%H%M"
alias today "date +%F"
alias hd "hexdump -C"
complete -c hd -w hexdump
alias o "gio open"
alias m "make -j(nproc)"
complete -c m -w make
