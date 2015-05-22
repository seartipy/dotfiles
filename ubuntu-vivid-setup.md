# My Ubuntu Gnome setup

If you are on a HiDPI screen, enter the following commands(gnome 3.x only)

    gsettings set org.gnome.desktop.interface text-scaling-factor .9
    gsettings set org.gnome.desktop.interface scaling-factor 2
    gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gdk/WindowScalingFactor': <2>}"

#### Essentials

    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install build-essential curl wget git linux-headers-`uname -r`
    sudo apt-get install tree tmux git-extras vim-gnome autojump silversearcher-ag editorconfig
    git clone https://github.com/pervezfunctor/dotfiles.git
    mkdir ~/bin

#### Git

    sudo add-apt-repository ppa:eugenesan/ppa
    sudo apt-get update
    sudo apt-get install git-extras smartgithg
    ln -s ~/dotfiles/common/gitconfig ~/.gitconfig

#### ZSH

    sudo apt-get install zsh
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    chsh -s /bin/zsh
    mv ~/.zshrc ~/.zshrc-backup
    ln -s ~/dotfiles/linux/zshrc ~/.zshrc

**In gnome terminal profile preferences, select 'Run command as a login shell and reboot**

#### Emacs

    sudo apt-get install emacs24 aspell aspell-en
    git clone https://github.com/purcell/emacs.d.git ~/.emacs.d
    ln -s ~/dotfiles/linux/init-local.el ~/.emacs.d/lisp/init-local.el

open emacs to install all packages, you can close it after the installations complete successfully

#### C++

    sudo apt-get install clang libclang-dev libc++-dev libc++abi-dev libboost1.55-all-dev g++ cppcheck

#### Java

    sudo add-apt-repository  ppa:webupd8team/java
    sudo apt-get update
    sudo apt-get install oracle-java8-installer

####Clojure

    curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
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

####Ruby

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    source ~/.rvm/scripts/rvm
    gem install pry  sinatra thin guard watchr tmuxinator sass --no-ri --no-rdoc

#### Misceleanous

    sudo add-apt-repository  ppa:nilarimogard/webupd8
    sudo add-apt-repository ppa:webupd8team/sublime-text-3
    sudo add-apt-repository  ppa:webupd8team/atom
    sudo apt-get update
    sudo apt-get install youtube-dl sublime-text-installer atom
