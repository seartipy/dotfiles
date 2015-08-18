#!/bin/bash

source utils.sh

# INSTALLER_SCRIPT_OPTIONS=(
#     'everything',
#     'essential',
#     'clojure',
#     'scala',
#     'cpp',
#     'python',
#     'web',
#     'haskell',
#     'ruby'
# )

if [ $# -ge 1 ]; then
    INSTALLER_SCRIPT=`echo $1 |  tr '[:upper:]' '[:lower:]' | xargs`
else
    INSTALLER_SCRIPT="everything"
fi

if [ "$(uname)" == "Darwin" ]; then
    OS="mac"
else
    OS="linux"
fi

DOTFILES="$HOME/$(dirname "$0")"

function install_git {
    if [ $OS == "mac" ]; then
        clang++ -v # install xcode to get git
    else
        sudo apt-get install git
    fi
}

install_git
sclone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles

secho "Installing $INSTALLER_SCRIPT ..."


source "$HOME/dotfiles/scripts/${OS}/${INSTALLER_SCRIPT}-setup.sh"
