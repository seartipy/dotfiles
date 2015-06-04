# My Yosemite setup

#### Install xcode from mac app store

Type the following in your os x terminal and click on Install xcode in the pop up window

    clang++ -v

#### Install homebrew and caskroom for homebrew

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install caskroom/cask/brew-cask

#### Essential

    brew update && brew upgrade
    brew install wget tree tmux fasd the_silver_searcher editorconfig ctags gibo
    brew cask install karabiner seil spectacle
    git clone https://github.com/pervezfunctor/dotfiles.git
    mkdir ~/bin

#### ZSH

    git clone https://github.com/zsh-users/antigen.git
    chsh -s /bin/zsh
    mv ~/.zshrc ~/.zshrc-backup
    ln -s ~/dotfiles/common/zshrc ~/.zshrc

#### Git

    brew install git-extras
    brew cask install smartgit
    cp ~/dotfiles/common/gitconfig ~/.gitconfig

#### Emacs

    brew tap railwaycat/emacsmacport
    brew install emacs-mac
    brew install aspell --with-lang-en
    git clone https://github.com/pervezfunctor/emacs.d.git ~/.emacs.d
    cd ~/.emacs.d && git checkout pervez && cd
    osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'

If you use zsh from inside emacs, you need the following

    tic -o ~/.terminfo /usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.8/share/emacs/24.5/etc/e/eterm-color.ti

**open emacs, you can close it after the installations complete successfully**

#### Vim

    brew install macvim --override-system-vim --with-lua --with-luajit
    brew linkapps macvim
    curl http://j.mp/spf13-vim3 -L -o - | sh
    osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/Cellar/macvim/7.4-76/MacVim.app" at POSIX file "/Applications"'

#### C++

    brew install boost --c++11
    brew install cmake scons boost-build
    brew cask install clion

#### Haskell

    brew install ghc cabal-install
    cabal update
    cabal install alex happy
    cabal install hlint
    cabal install hoogle
    cabal install structured-haskell-mode

ghc-mod unfortunately does not build with ghc 7.10. Bug is fixed in master so need to clone master

    git clone git@github.com:kazu-yamamoto/ghc-mod.git ~/ghc-mod
    cabal install ~/ghc-mod

#### Java

    brew cask install java
    brew cask install caskroom/homebrew-versions/java6
    brew cask install  intellij-idea scala-ide

#### Clojure

    brew install leiningen
    lein repl
    ln -s ~/dotfiles/common/profiles.clj ~/.lein/profiles.clj
    lein repl

#### Scala

    brew install sbt scala
    sbt console
    mkdir ~/.sbt/0.13/plugins
    ln -s ~/dotfiles/common/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt
    sbt console

##### Javascript

    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install 0.12
    nvm alias default 0.12
    source ~/.nvm/nvm.sh
    npm install -g coffee-script typescript babel
    npm install -g grunt-cli gulp bower browserify webpack
    npm install -g tap karma-cli jest jshint coffeelint
    npm install -g jstransform react-tools
    git clone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install
    brew install flow

####Ruby

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    source ~/.rvm/scripts/rvm
    gem install pry sinatra thin guard watchr tmuxinator sass --no-ri --no-rdoc

#### Miscellaneous

    brew install p7zip unrar trash coreutils
    brew cask install atom google-chrome iterm2 dash android-file-transfer
    brew cask install virtualbox transmission macdown github
    brew tap caskroom/versions
    brew cask install sublime-text3
