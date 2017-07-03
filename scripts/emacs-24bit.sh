#! /usr/bin/env bash

source "$HOME/seartipy/dotfiles/scripts/utils.sh"

if ! is_ubuntu; then
    echo "supported only in ubuntu"
fi

add_emacs_ppa() {
    ppa_exists elisp && return 0
    sudo add-apt-repository ppa:ubuntu-elisp/ppa
}

emacs_snapshot_install() {
    has_cmd emacs-snapshot && return 0
    add_emacs_ppa
    sudo apt-get update
    sudo apt-get install -y emacs-snapshot
}

emacs_snapshot_check() {
    has_cmd emacs-snapshot
    file_check ~/.terminfo/x/xterm-24bit
    file_check ~/.terminfo/x/xterm-24bits
}

main() {
    srm ~/.terminfo
    tic -x -o ~/.terminfo ~/seartipy/dotfiles/templates/terminfo-24bit.src
    emacs_snapshot_install
    emacs_snapshot_check
}

main
