#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If running from tty1 start sway
if [[ "$(tty)" == "/dev/tty1" ]]; then
	exec systemd-cat -t sway sway
fi

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

# Prompt Configuration
_prompt_cmd() {
    # must be the first
    status=$?

    history -a
    history -c
    history -r

    __git_ps1 '\e[0;32m\u\e[m@\h \w' '$(if (( $status != 0 )); then echo " \e[0;31m[$status]\e[m"; fi)\$ '
}

PROMPT_COLOR="y"
PROMPT_DIRTRIM=2
PROMPT_COMMAND="_prompt_cmd"

if [[ -f /usr/share/git/git-prompt.sh ]]; then
    if [[ "$PROMPT_COLOR" == "y" ]]; then
        GIT_PS1_SHOWCOLORHINTS='y'
        GIT_PS1_SHOWDIRTYSTATE='y'
        source /usr/share/git/git-prompt.sh
    else
        source /usr/share/git/git-prompt.sh
        PS1='[\u@\h \w$(__git_ps1 " (%s)")]$(if (( $status != 0 )); then echo " ($status)"; fi)\$ '
    fi
else
    PS1='[\u@\h \w]\$ '
fi

# Aliases
alias ls='ls --color=auto'
alias la='ls -lah'
alias grep='grep --color=auto'

# Keybindings
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
    source /usr/share/fzf/key-bindings.bash
fi

# Additional Completions
if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash

    # pass completion suggested by @d4ndo (#362)
    _fzf_complete_pass() {
      _fzf_complete '+m' "$@" < <(
        pwdir=${PASSWORD_STORE_DIR-~/.password-store/}
        stringsize="${#pwdir}"
        find "$pwdir" -name "*.gpg" -print |
            cut -c "$((stringsize + 1))"-  |
            sed -e 's/\(.*\)\.gpg/\1/'
      )
    }

    complete -F _fzf_complete_pass -o default -o bashdefault pass
fi

