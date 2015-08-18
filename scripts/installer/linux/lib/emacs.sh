sudo apt-get install emacs24 editorconfig exuberant-ctags silversearcher-ag aspell aspell-en

git clone --recursive https://github.com/syl20bnr/spacemacs $SEARTIPY_HOME/spacemacs.d # spacemacs
git clone https://github.com/purcell/emacs.d.git $SEARTIPY_HOME/purcell.d # purcell emacs
https://github.com/bbatsov/prelude.git $SEARTIPY_HOME/prelude.d # batsove prelude
git clone https://github.com/magnars/.emacs.d.git $SEARTIPY_HOME/magnars.d

git clone https://github.com/pervezfunctor/emacs.d.git $SEARTIPY_HOME/housem.d # my emacs
ln -s $SEARTIPY_HOME/housem.d ~/.emacs.d
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd $SEARTIPY_HOME/housem.d && ~/.cask/bin/cask install
popd
