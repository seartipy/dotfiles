#!/bin/bash

echo "Installing required packages..."

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
    sudo add-apt-repository  ppa:webupd8team/java -y
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y curl oracle-java8-installer git emacs24 silversearcher-ag exuberant-ctags editorconfig tree  aspell-en unrar trash-cli
else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install caskroom/cask/brew-cask
    brew tap railwaycat/emacsmacport

    brew install emacs-mac --with-spacemacs-icon
    brew install aspell --with-lang-en
    brew cask install java
    brew install wget tree tmux fasd the_silver_searcher editorconfig ctags emacs-mac unrar p7zip trash coreutils trash leiningen
fi

echo "Setting up bash..."

cd
[ -e ~/liquidprompt ] || git clone https://github.com/nojhan/liquidprompt.git ~/liquidprompt
if ! grep liquidprompt ~/.bashrc
then
    echo "[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt" >> ~/.bashrc
fi

echo "Setting up emacs..."

[ -e ~/spacemacs ] || git clone --recursive https://github.com/syl20bnr/spacemacs ~/spacemacs
mv ~/.emacs.d ~/.emacs.d.seartipy.backup 2> /dev/null
ln -s ~/spacemacs ~/.emacs.d
mv ~/.spacemacs ~/.spacemacs.seartipy.backup 2> /dev/null
curl https://github.com/pervezfunctor/dotfiles/blob/master/common/spacemacs > ~/.spacemacs

if [[ "$OSTYPE" == "darwin"* ]]; then

    osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'
    tic -o ~/.terminfo /usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.8/share/emacs/24.5/etc/e/eterm-color.ti
fi

emacs&

echo "Setting up clojure..."

if [[ "$OSTYPE" == "linux-gnu" ]]; then

    [-e ~/bin ] || mkdir ~/bin
    echo "export PATH=\$HOME/bin:\$PATH" >> ~/.bashrc
    source ~/.bashrc

    mv ~/bin/lein ~/bin/lein.seartipy.backup 2> /dev/null
    curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
    chmod +x ~/bin/lein
fi

mkdir ~/.lein 2> /dev/null
mv ~/.lein/profiles.clj ~/.lein/profiles.clj.seartipy.backup 2> /dev/null
curl https://raw.githubusercontent.com/pervezfunctor/dotfiles/master/common/profiles.clj > ~/.lein/profiles.clj
mkdir -p ~/programs/clojure 2> /dev/null
cd ~/programs/clojure
[ -e hello-clojure-world ] || lein new app hello-clojure-world
cd hello-clojure-world
lein repl

echo "Please reboot your system!"
