#!/bin/bash

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

SEARTIPY_HOME=$HOME/seartipy
DOTFILES=$SEARTIPY_HOME/dotfiles
INSTALLER_SCRIPTS=$SEARTIPY_HOME/dotfiles/scripts/installer

function install_git {
    if [ $OS == "mac" ]; then
        clang++ -v # install xcode to get git
    else
        sudo apt-get install git
    fi
}

install_git
mkdir -p SEARTIPY_HOME/{emacses,vendors} > /dev/null
if [ -e $SEARTIPY_HOME/dotfiles ]; then
    pushd . > /dev/null
    cd $SEARTIPY_HOME/dotfiles && git pull origin master
    popd > /dev/null
else
    git clone https://github.com/pervezfunctor/dotfiles.git $SEARTIPY_HOME/dotfiles
fi
source $INSTALLER_SCRIPTS/utils.sh

secho "Installing $INSTALLER_SCRIPT ..."


source "$INSTALLER_SCRIPTS/${OS}/${INSTALLER_SCRIPT}-setup.sh"
