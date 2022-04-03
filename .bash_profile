#
# ~/.bash_profile
#
# shellcheck shell=bash

export SHELL="/usr/bin/fish"
export EDITOR="nvim"
export PAGER="less"
export MANWIDTH="80"
export MANOPT="--nj --nh"
export MANPAGER="nvim -u NORC +Man!"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/usr/bin/vendor_perl"
export GOPATH="$HOME/.local/share/go"

# Wayland
# https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
# export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# # export QT_WAYLAND_FORCE_DPI=physical
# export QT_QPA_PLATFORM=xcb
# export SAL_USE_VCLPLUGIN=gtk3
# export SDL_VIDEODRIVER=wayland
# export MOZ_ENABLE_WAYLAND=1
# export MOZ_DBUS_REMOTE=1
# export XDG_CURRENT_DESKTOP=sway

# export _JAVA_AWT_WM_NONREPARENTING=1
# export QT_QPA_PLATFORM=wayland-egl
# export GDK_BACKEND=wayland

# export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"
# export SSH_AUTH_SOCK="/run/user/$UID/keyring/ssh"

# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus

if [[ -d "$HOME/.local/bin" ]] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# If running from tty1 start sway
# if [[ "$(tty)" == "/dev/tty1" ]]; then
#     eval "$(gnome-keyring-daemon --daemonize)"
#     export SSH_AUTH_SOCK
#     # export WLR_NO_HARDWARE_CURSORS=1
#     exec systemd-cat -t sway sway
# fi

if [[ -f "$HOME/.bashrc" ]]; then
    source "$HOME/.bashrc"
fi
