#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ls='ls --color=auto'
alias la='ls -lah'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# Misc
shopt -s autocd
shopt -s checkwinsize

# History Config
shopt -s histappend
shopt -s cmdhist

HISTSIZE=-1
HISTFILESIZE=-1
HISTCONTROL="ignoreboth"
HISTTIMEFORMAT="[%F %T] "
HISTIGNORE='ls:bg:fg:history:htop'

# If running from tty1 start sway
if [[ "$(tty)" == "/dev/tty1" ]]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
    # https://github.com/systemd/systemd/issues/14489
    export XDG_SESSION_TYPE=wayland
    exec systemd-cat -t sway sway
fi

