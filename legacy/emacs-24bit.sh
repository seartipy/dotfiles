#! /usr/bin/env bash

source "$HOME/seartipy/dotfiles/scripts/utils.sh"

main() {
    if ! is_ubuntu && ! is_mac; then
        echo "Only mac and ubuntu supported"
    fi

    echo "generating terminfo"
    tic -x -o ~/.terminfo ~/seartipy/dotfiles/templates/terminfo-24bit.src
}

main
