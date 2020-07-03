# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

export SHELL="/usr/bin/fish"
export EDITOR="nvim"
export PAGER="less"
export MANWIDTH="80"
export MANOPT="--nj --nh"
export MANPAGER="nvim -u NORC +Man!"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:/usr/bin/vendor_perl"

# Wayland
# https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# export QT_WAYLAND_FORCE_DPI=physical
export SAL_USE_VCLPLUGIN=gtk3
export SDL_VIDEODRIVER=wayland
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export XDG_CURRENT_DESKTOP=sway

export _JAVA_AWT_WM_NONREPARENTING=1
# export QT_QPA_PLATFORM=wayland-egl
# export GDK_BACKEND=wayland

export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

