cleanup_ubuntu() {
    is_ubuntu || return 1
    sudo apt-get clean
    sudo apt-get autoclean
    sudo apt-get autoremove -y
}

cleanup_mac() {
    is_mac || return 1

    slog "cleanup brew"
    brew cleanup
}

cleanup() {
    cleanup_ubuntu
    cleanup_mac
}

