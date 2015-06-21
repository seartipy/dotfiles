# My Ubuntu Gnome setup

If you are on a HiDPI screen, enter the following commands(gnome 3.x only)

    gsettings set org.gnome.desktop.interface text-scaling-factor .9
    gsettings set org.gnome.desktop.interface scaling-factor 2
    gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <2>}"

For Ubuntu Unity please also select 2 for "Scale for menu and title bars" in System Settings/Displays

#### Essentials

    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install build-essential linux-headers-`uname -r`
    sudo apt-get install exfat-fuse exfat-utils
    sudo apt-get install curl wget tree tmux git terminator
    sudo apt-get install xsel
    sudo apt-get install autojump silversearcher-ag exuberant-ctags editorconfig
    git clone https://github.com/pervezfunctor/dotfiles.git
    mkdir ~/bin

#### ZSH

**In gnome terminal profile preferences, select 'Run command as a login shell**

    sudo apt-get install zsh
    chsh -s /bin/zsh
    git clone https://github.com/zsh-users/antigen.git
    mv ~/.zshrc ~/.zshrc-backup
    ln -s ~/dotfiles/common/zshrc ~/.zshrc

**Recommended to reboot your system**

#### Git

    sudo add-apt-repository ppa:eugenesan/ppa -y
    sudo apt-get update
    sudo apt-get install git-extras smartgithg
    cp ~/dotfiles/common/gitconfig ~/.gitconfig

#### Emacs

    sudo apt-get install emacs24 aspell aspell-en
    git clone https://github.com/pervezfunctor/emacs.d.git ~/.emacs.d
    cd ~/.emacs.d && git checkout pervez && cd

**Open emacs to install all packages, you can close it after the installations complete successfully.**

#### Vim

    sudo apt-get install vim-gnome
    curl http://j.mp/spf13-vim3 -L -o - | sh

#### Haskell

    sudo add-apt-repository ppa:hvr/ghc -y
    sudo apt-get update
    sudo apt-get install ghc-7.10.2 cabal-install-1.22
    cabal update
    cabal install alex happy
    cabal install hlint
    cabal install hoogle
    cabal install structured-haskell-mode
    cabal install stylish-haskell hasktags hident

ghc-mod unfortunately does not build with ghc 7.10. Bug is fixed in master so need to clone master

    git clone https://github.com/kazu-yamamoto/ghc-mod.git ~/ghc-mod
    cabal install ~/ghc-mod

#### Java

    sudo add-apt-repository  ppa:webupd8team/java -y
    sudo apt-get update
    sudo apt-get install oracle-java8-installer

**Download and install Scala IDE and Intellij Idea**

#### C++

    sudo apt-get install clang libclang-dev libc++-dev libc++abi-dev
    sudo apt-get install libboost1.55-all-dev g++ cppcheck scons cmake

**Download and install CLion from Jetbrains**

####Clojure

    curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
    chmod +x ~/bin/lein
    lein repl
    ln -s ~/dotfiles/common/profiles.clj ~/.lein/profiles.clj
    lein repl

####Scala

    echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
    sudo apt-get update
    sudo apt-get install sbt
    sbt console
    mkdir ~/.sbt/0.13/plugins
    ln -s ~/dotfiles/common/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt
    sbt console

####Javscript

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

**Download and install flow**

####Ruby

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    source ~/.rvm/scripts/rvm
    gem install pry  sinatra thin guard watchr tmuxinator sass --no-ri --no-rdoc

####Python

    git clone https://github.com/yyuu/pyenv.git ~/.pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
    echo 'eval "$(pyenv init -)"' >> ~/.zshenv
    git clone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
    git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshenv

Restart your shell

    exec $SHELL
    pyenv install anaconda3-2.2.0
    pyenv global anaconda3-2.2.0
    pip install --upgrade pip
    pip install flake8 pylint
    pyenv global system

#### Misceleanous

    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian vivid contrib" >> /etc/apt/sources.list'
    sudo add-apt-repository  ppa:nilarimogard/webupd8 -y
    sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
    sudo add-apt-repository  ppa:webupd8team/atom -y
    sudo add-apt-repository ppa:zeal-developers/ppa -y
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo apt-get update
    sudo apt-get install youtube-dl sublime-text-installer atom zeal google-chrome-stable virtualbox-4.3 dkms
    curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so ~/bin/gibo && chmod +x ~/bin/gibo && gibo -u
    git clone https://github.com/clvv/fasd.git
    cd fasd && PREFIX=$HOME make install && cd

**Download and install virtualbox extensions pack from virtualbox.org**
