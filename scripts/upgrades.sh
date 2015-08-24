function spull {
    if [ -e $1 ]; then
        cd $1
        if git status --porcelain > /dev/null; then
            git-up
        fi
        popd > /dev/null
    fi
}

function upgrade_system {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        sudo apt-get update && sudo apt-get upgrade -y
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew update && brew upgrade && brew cleanup && brew cask cleanup
    fi
}

function upgrade_dotfiles {
    spull SEARTIPY_HOME/dotfiles
}

function upgrade_spacemacs {
    git pull --rebase
    git submodule sync; git submodule update
}

function upgrade_emacs {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        cask upgrade
    fi
    spull $SEARTIPY_HOME/emacses/housem.d
    pushd . > /dev/null
    cd $SEARTIPY_HOME/emacses/housem.d > /dev/null && cask update
    popd > /dev/null

    upgrade_spacemacs

    spull SEARTIPY_HOME/emacses/purcell
    spull SEARTIPY_HOME/emacses/prelude
    spull SEARTIPY_HOME/emacses/magnars
}

function upgrade_clojure {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        lein upgrade
    fi
    if [ $USER == "pervez" ]; then
        lein ancient upgrade-profiles :allow-snapshots
    fi
}

function upgrade_scala {
    expect > /dev/null <<EOF
spawn sbt console
expect "scala>"
send ":quit\r"
EOF
}

function upgrade_web {
    nvm install stable
    npm upgrade -g
}

function upgrade_all {
    upgrade
    upgrade_dotfiles
    upgrade_emacs
    upgrade_clojure
    upgrade_scala
    upgrade_web
}
