#! /usr/bin/env bash

{

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

source "$DOTFILES_DIR/scripts/utils.sh"

seartipy_fix_links() {
    if ! [ -d ~/seartipy/dotfiles ]; then
        smd ~/seartipy
        git clone https://gitlab.com/seartipy/dotfiles.git ~/seartipy/dotfiles
    fi
    if ! [ -d ~/seartipy/dotfiles ]; then
        error "no ~/seartipy/dotfiles, cannot fix links"
    fi

    # bash
    sln ~/seartipy/dotfiles/bashrc ~/.bash_profile
    is_mac && sln ~/seartipy/dotfiles/bashrc ~/.bashrc
    if is_linux && ! grep .bash_profile ~/.bashrc > /dev/null; then
        echo "[ -f ~/.bash_profile ] && source ~/.bash_profile" >> ~/.bashrc
    fi

    # zsh
    has_cmd zsh && sln ~/seartipy/dotfiles/zgen-zshrc ~/.zshrc

    # emacs
    has_cmd emacs && sln ~/seartipy/emacses/emacsd ~/.emacs.d

    # clojure
    if has_cmd lein; then
        smd ~/.lein
        sln ~/seartipy/dotfiles/lein-profiles.clj ~/.lein/profiles.clj
    fi

    # scala
    if has_cmd sbt; then
        smd ~/.sbt/1.0/plugins
        sln ~/seartipy/dotfiles/sbt-plugins.sbt ~/.sbt/1.0/plugins/plugins.sbt
        sln ~/seartipy/dotfiles/sbt-global.sbt ~/.sbt/1.0/global.sbt
    fi

    has_cmd tmux && sln ~/seartipy/dotfiles/tmux.conf ~/.tmux.conf

    is_mac && sln ~/seartipy/dotfiles/amethyst ~/.amethyst

    if has_cmd xmonad; then
        smd ~/.xmonad
        sln ~/seartipy/dotfiles/xmonad.hs ~/.xmonad/xmonad.hs
    fi
}
