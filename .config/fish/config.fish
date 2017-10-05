# This file is run by all fish instances.
# To include configuration only for login shells, use
# if status --is-login
#    ...
# end
# To include configuration only for interactive shells, use
# if status --is-interactiv
#   ...
# end

export TERMINAL="gnome-terminal"
export BROWSER="chromium"
export EDITOR="nvim"
export PAGER="less"
export MANWIDTH="80"
export MANOPT="--nj --nh"
export MANPAGER="nvim -c 'set ft=man' -"

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS="-F -g -i -M -R -S -w -X -z-4"
alias dmesg="journalctl -keb"
alias dmesgf="journalctl -kf"
alias cal="ncal -b"

function __fish_set_oldpwd --on-variable dirprev
  set -g OLDPWD $dirprev[-1]
end

function fish_greeting
end

function man
    if test $argv[1] = "--web"
        set -l codename (lsb_release -c | awk '{print $2}')
        set -l url https://manpages.debian.org/$codename/$argv[2]
        gnome-open $url
    else
        command man $argv
    end
end
