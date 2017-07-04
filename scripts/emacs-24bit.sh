#! /usr/bin/env bash

source "$HOME/seartipy/dotfiles/scripts/utils.sh"

add_emacs_ppa() {
    is_ubuntu || return 1
    ppa_exists elisp && return 0
    sudo add-apt-repository ppa:ubuntu-elisp/ppa
}

emacs_snapshot_mac_install() {
    is_mac || return 1
    srm /Applications/Emacs.app
    brew tap caskroom/versions
    brew cask install emacs-nightly
}

emacs_snapshot_ubuntu_install() {
    has_cmd emacs-snapshot && return 0
    add_emacs_ppa
    sudo apt-get update
    sudo apt-get install -y emacs-snapshot
}

emacs_snapshot_check() {
    if is_ubuntu; then
     has_cmd emacs-snapshot
     file_check ~/.terminfo/x/xterm-24bit
     file_check ~/.terminfo/x/xterm-24bits
    elif is_mac; then
        dir_check ~/.terminfo
        file_check /Applications/Emacs.app
    fi
}

emacs_snapshot_install() {
    emacs_snaphost_mac_install
    emacs_snapshot_ubuntu_install
}

main() {
    if ! is_ubuntu || ! is_mac; then
        echo "Only mac and ubuntu supported"
    fi

    tic -x -o ~/.terminfo ~/seartipy/dotfiles/templates/terminfo-24bit.src

    emacs_snapshot_install

    emacs_snapshot_check
}

main
