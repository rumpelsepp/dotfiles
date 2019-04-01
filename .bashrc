#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	sway
	exit 0
fi
