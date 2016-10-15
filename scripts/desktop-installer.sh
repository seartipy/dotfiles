#! /bin/bash

source "$HOME/seartipy/dotfiles/scripts/utils.sh"

common_install() {
    sudo apt install --no-install-recommends arc-theme ttf-ubuntu-font-family policykit-1
}

i3_install() {
    sudo apt install --no-install-recommends i3 i3status
}

lxde_install() {
    sudo apt install --no-install-recommends lxde-core lxsession-logout lxde-common lxdm obconf lxappearance arc-theme ttf-ubuntu-font-family lxterminal lxpolkit
}

xfce_install() {
    # lxdm does not work for some reason
    sudo apt install --no-install-recommends xfce4  xfce4-terminal slim
}

mate_install() {
    # might need to install mate-applets-common at least, may want mate-control-center too
    # you need to set window manager, as marco is not installed
    sudo apt install --no-install-recommends mate-desktop mate-panel mate-polkit mate-session-manager mate-settings-daemon dconf-editor slim mate-terminal
}

mate_recommended_install() {
    # might need to install mate-applets-common at least, may want mate-control-center too
    # you need to set window manager, as marco is not installed
    sudo apt install --no-install-recommends mate-desktop mate-panel mate-polkit mate-session-manager mate-settings-daemon dconf-editor slim mate-terminal mate-control-center mate-applet-topmenu tilda
}

budgie_install() {
    sudo apt install --no-install-recommends budgie-core gdm gnome-terminal
}

gnome_install() {
    sudo apt install --no-install-recommends gnome-session gdm gnome-terminal
}

gnome_recommended_install() {
    sudo apt install --no-install-recommends gnome-session gdm gnome-terminal gnome-tweak-tool gnome-control-center
}

is_yakkety || err_exit "currently only Ubuntu 16.10 supported"
