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

curdir=`pwd`

if [ $# -ge 1 ]; then
    CHOICE=`echo $1 |  tr '[:upper:]' '[:lower:]' | xargs`
else
    CHOICE="everything"
fi

function keep-sudo-running {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until `.osx` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

function setup-variables {
    if [ "$(uname)" == "Darwin" ]; then
        export OS="mac"
    else
        export OS="linux"
    fi
    SEARTIPY_HOME=$HOME/seartipy
    DOTFILES=$SEARTIPY_HOME/dotfiles
    INSTALLER_SCRIPTS=$SEARTIPY_HOME/dotfiles/scripts/installer
}

function install-git {
    if [ "$OS" == "mac" ]; then
        clang++ -v # install xcode to get git
    else
        sudo apt-get install git
    fi
}

function source-shell-scripts {
    source $INSTALLER_SCRIPTS/utils.sh

    source $DOTFILES/scripts/aliases.sh
    source $DOTFILES/scripts/exports.sh
    source $DOTFILES/scripts/sources.sh
}

function clone-dotfiles {
    if [ -e $SEARTIPY_HOME/dotfiles ]; then
        cd $SEARTIPY_HOME/dotfiles && git pull origin master
    else
        git clone https://github.com/pervezfunctor/dotfiles.git $SEARTIPY_HOME/dotfiles
    fi
}

function create-folders {
    smkdir $SEARTIPY_HOME/{emacses,vendors}
    smkdir $HOME/bin
}

function initialize {
    keep-sudo-running
    setup-variables
    install-git
    clone-dotfiles
    source-shell-scripts
    create-folders
}

function installer {
    secho "Installing $CHOICE ..."

    source $INSTALLER_SCRIPTS/$OS/essential.sh
    source $INSTALLER_SCRIPTS/$OS/emacs.sh
    source $INSTALLER_SCRIPTS/$OS/git.sh

    if [ "$CHOICE" == "everything" ]; then
        source $INSTALLER_SCRIPTS/$OS/java.sh
        source $INSTALLER_SCRIPTS/$OS/clojure.sh
        source $INSTALLER_SCRIPTS/$OS/scala.sh
        source $INSTALLER_SCRIPTS/$OS/web.sh
        source $INSTALLER_SCRIPTS/$OS/cpp.sh
        source $INSTALLER_SCRIPTS/$OS/haskell.sh
        source $INSTALLER_SCRIPTS/$OS/python.sh
        source $INSTALLER_SCRIPTS/$OS/ruby.sh
        source $INSTALLER_SCRIPTS/$OS/additional.sh
        source $INSTALLER_SCRIPTS/$OS/settings.sh
    elif [ "$CHOICE" != "essential" ]; then
        if [ "$CHOICE" == "clojure" ] || [ "$CHOICE" == "scala" ]; then
            source $INSTALLER_SCRIPTS/$OS/java.sh
        fi
        source "$INSTALLER_SCRIPTS/$OS/$CHOICE.sh"
    fi

    source $INSTALLER_SCRIPTS/$OS/bash.sh
    source $INSTALLER_SCRIPTS/$OS/zsh.sh

    if [ "$CHOICE" == "everything" ]; then
        source $INSTALLER_SCRIPTS/$OS/vim.sh
    fi
}

initialize
installer

cd $curdir
