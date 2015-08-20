sudo apt-get install -y emacs24
sudo apt-get install -y aspell aspell-en
sudo apt-get install -y editorconfig
sudo apt-get install -y exuberant-ctags
sudo apt-get install -y silversearcher-ag

git clone --recursive https://github.com/syl20bnr/spacemacs $SEARTIPY_HOME/emacses/spacemacs.d # spacemacs
sln $SEARTIPY_HOME/dotfiles/common/spacemacs ~/.spacemacs

git clone https://github.com/pervezfunctor/emacs.d.git $SEARTIPY_HOME/emacses/housem.d # my emacs
ln -s $SEARTIPY_HOME/emacses/housem.d ~/.emacs.d
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd $SEARTIPY_HOME/emacses/housem.d && ~/.cask/bin/cask install
popd

git clone https://github.com/purcell/emacs.d.git $SEARTIPY_HOME/emacses/purcell.d # purcell emacs
git clone https://github.com/bbatsov/prelude.git $SEARTIPY_HOME/emacses/prelude.d # batsov prelude
git clone https://github.com/magnars/.emacs.d.git $SEARTIPY_HOME/emacses/magnars.d
