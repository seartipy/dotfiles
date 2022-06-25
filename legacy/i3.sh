i3_ubuntu_install() {
    is_ubuntu ||  return 1

    sudo apt-get install -y i3-wm rofi suckless-tools i3status
}

i3_install() {
    is_linux || return 1

    slog "i3 setup"

    i3_ubuntu_install

    scopy ~/seartipy/dotfiles/templates/desktops/i3-config ~/.i3/config
}
