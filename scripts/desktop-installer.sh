#! /bin/bash

source "$HOME/seartipy/dotfiles/scripts/utils.sh"

common_install() {
    sudo apt install --no-install-recommends arc-theme ttf-ubuntu-font-family policykit-1
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
    sudo apt install --no-install-recommends mate-desktop mate-panel mate-polkit mate-session-manager mate-settings-daemon dconf-editor slim
}

is_yakkety || err_exit "currently only Ubuntu 16.10 supported"
