#!/bin/bash

echo "Installing required packages..."

function install_ubuntu_packages {
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
    sudo add-apt-repository  ppa:webupd8team/java -y
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y curl oracle-java8-installer git emacs24 silversearcher-ag expect
    sudo apt-get install -y aspell-en trash-cli
}

function install_mac_packages {
    if ! brew -v; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    brew install caskroom/cask/brew-cask
    brew tap railwaycat/emacsmacport
    brew install emacs-mac --with-spacemacs-icon
    brew install aspell --with-lang-en
    brew cask install java
    brew install wget the_silver_searcher trash leiningen expect
}

function setup_liquidprompt {
    if ! [ -e ~/seartipy/vendors/liquidprompt ]; then
         git clone https://github.com/nojhan/liquidprompt.git ~/seartipy/vendors/liquidprompt
    fi

    if ! grep liquidprompt ~/.bashrc
    then
        echo "[[ $- = *i* ]] && source ~/seartipy/vendors/liquidprompt/liquidprompt" >> ~/.bashrc
    fi
}

function setup_emacs {
    if [ -e ~/seartipy/spacemacs ]; then
        pushd .
        cd ~/seartipy/spacemacs
        if git status --porcelain; then
            git pull
        fi
        popd
    else
        git clone --recursive https://github.com/syl20bnr/spacemacs ~/seartipy/spacemacs
    fi
    mv -f -b ~/.emacs.d ~/.emacs.d.seartipy.backup 2> /dev/null
    ln -s ~/seartipy/spacemacs ~/.emacs.d

    mv -f -b ~/.spacemacs ~/.spacemacs.seartipy.backup 2> /dev/null
    if ! [ -e ~/.spacemacs ]; then
         curl -L https://raw.githubusercontent.com/pervezfunctor/dotfiles/master/common/spacemacs > ~/.spacemacs
    fi
    if [[ "$OSTYPE" == "darwin"* ]]; then
        osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'
        tic -o ~/.terminfo /usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.8/share/emacs/24.5/etc/e/eterm-color.ti
    fi
}

function setup_clojure {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then

        [-e ~/bin ] || mkdir ~/bin
        if ! grep "\$HOME/bin" ~/.bashrc > /dev/null; then
            echo "export PATH=\$HOME/bin:\$PATH" >> ~/.bashrc
        fi
        if ! grep "\$HOME/bin" ~/.zshrc > /dev/null; then
            echo "export PATH=\$HOME/bin:\$PATH" >> ~/.zrc
        fi
        export PATH=$PATH:$HOME/bin
        if ! lein > /dev/null; then
            mv -f -b ~/bin/lein ~/bin/lein.seartipy.backup 2> /dev/null
            curl -L https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
            chmod +x ~/bin/lein
        else
            lein upgrade
        fi
    fi

    [ -e ~/.lein ] || mkdir ~/.lein 2> /dev/null
    mv -f -b /.lein/profiles.clj ~/.lein/profiles.clj.seartipy.backup 2> /dev/null
    curl -L https://raw.githubusercontent.com/pervezfunctor/dotfiles/master/common/profiles.clj > ~/.lein/profiles.clj
    mkdir -p ~/programs/clojure 2> /dev/null
    cd ~/programs/clojure
    [ -e hello-clojure-world ] || lein new app hello-clojure-world
    cd hello-clojure-world

    expect > /dev/null <<EOF
spawn lein repl
expect "user => "
send "exit\r"
EOF
}

function installer {
    pushd .
    cd

    echo "Installing packages..."
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        install_ubuntu_packages
    else
        install_mac_packages
    fi

    [ -e ~/seartipy ] || mkdir ~/seartipy

    echo "Setting up liquidprompt for bash..."
    setup_liquidprompt

    echo "Setting up emacs..."
    setup_emacs

    echo "Setting up clojure..."
    setup_clojure

    popd
    echo "Please reboot your system!"
}
