# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export SHELL="/usr/bin/fish"
export DEBEMAIL="stefan@rumpelsepp.org"
export DEBFULLNAME="Stefan Tatschner"
export EDITOR="nvim"
export PAGER="less"
export MANWIDTH="80"
export MANOPT="--nj --nh"
export MANPAGER="nvim +Man!"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games"

export KITTY_ENABLE_WAYLAND=1
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_QPA_PLATFORM=wayland-egl
export GDK_BACKEND=wayland

# Only works when ssh component of gnome-keyring is disabled
# https://wiki.archlinux.org/index.php/GNOME/Keyring#Disable_keyring_daemon_components
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/go" ] ; then
    export GOPATH=$HOME/go
    export PATH="$GOPATH/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.gem/bin" ] ; then
    export PATH="$HOME/.gem/bin:$PATH"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
