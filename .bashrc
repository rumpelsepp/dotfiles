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


source /home/rumpelsepp/.config/broot/launcher/bash/br
