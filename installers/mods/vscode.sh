# vscode

ubuntu_vscode_install() {
    is_ubuntu || return 1

    sudo deb-get install code
}

mac_vscode_install() {
    is_mac || return 1

    brew install visual-studio-code
}

vscode_install() {
    ubuntu_vscode_install
    mac_vscode_install
}

vscode_check() {
    cmd_check code
}
