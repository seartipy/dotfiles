#### dotfiles

git clone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles
mkdir ~/bin

#### zsh

# In gnome terminal profile preferences, select 'Run command as a login shell

git clone https://github.com/zsh-users/antigen.git ~/antigen
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup
ln -s ~/dotfiles/common/zshrc ~/.zshrc
ln -s ~/dotfiles/common/tmux.conf ~/.tmux.conf

#### git

cp ~/dotfiles/common/gitconfig ~/.gitconfig

#### emacs

git clone https://github.com/pervezfunctor/emacs.d.git ~/.emacs.d

#### vim

curl http://j.mp/spf13-vim3 -L -o - | sh

#### Haskell

cabal update
cabal install alex happy
cabal install hlint
cabal install hoogle
cabal install structured-haskell-mode
cabal install stylish-haskell hasktags hident
cabal install hdevtools

git clone https://github.com/kazu-yamamoto/ghc-mod.git ~/ghc-mod
cabal install ~/ghc-mod

#### java

# download and install Scala IDE and Intellij Idea

#### c++

# download and install CLion from Jetbrains

#### clojure

curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
chmod +x ~/bin/lein
mkdir ~/.lein
ln -s ~/dotfiles/common/profiles.clj ~/.lein/profiles.clj

#### scala

mkdir -p ~/.sbt/0.13/plugins
ln -s ~/dotfiles/common/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt

#### javascript

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 0.12
nvm alias default 0.12
source ~/.nvm/nvm.sh
npm install -g coffee-script typescript babel
npm install -g grunt-cli gulp bower browserify webpack
npm install -g tap karma-cli jest jshint coffeelint
npm install -g jstransform react-tools
pushd . && git clone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install && popd

# Download and install flow

#### ruby

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm
gem install pry  sinatra thin guard watchr tmuxinator sass --no-ri --no-rdoc

#### python

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
echo 'eval "$(pyenv init -)"' >> ~/.zshenv
git clone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshenv

exec $SHELL
pyenv install anaconda3-2.2.0
pyenv global anaconda3-2.2.0
pip install --upgrade pip
pip install flake8 pylint
pyenv global system

#### misceleanous

curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so ~/bin/gibo && chmod +x ~/bin/gibo && ~/bin/gibo -u
git clone https://github.com/clvv/fasd.git ~/fasd
cd ~/fasd && PREFIX=$HOME make install && cd

#### source code pro fonts

wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
unzip 1.030R-it.zip
mkdir ~/.fonts
cp 1.030R-it.zip/OTF/*.otf ~/.fonts
fc-cache -f -v
rm -f 1.030R-it.zip

## external commands
emacs
~/bin/lein repl
sbt console
chsh -s /bin/zsh
