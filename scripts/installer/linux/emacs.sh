sudo apt-get install -y emacs24
sudo apt-get install -y aspell aspell-en
sudo apt-get install -y editorconfig
sudo apt-get install -y exuberant-ctags
sudo apt-get install -y silversearcher-ag

sclone https://github.com/syl20bnr/spacemacs $SEARTIPY_HOME/emacses/spacemacs.d --recursive # spacemacs
sln $SEARTIPY_HOME/dotfiles/common/spacemacs ~/.spacemacs

sclone https://github.com/pervezfunctor/emacs.d.git $SEARTIPY_HOME/emacses/housem.d # my emacs
if [ $USER == "pervez" ]; then
    sln $SEARTIPY_HOME/emacses/housem.d ~/.emacs.d
else
    sln $SEARTIPY_HOME/emacses/spacemacs.d ~/.emacs.d
fi

if ! cask --version > /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
fi
pushd . > /dev/null
cd $SEARTIPY_HOME/emacses/housem.d && ~/.cask/bin/cask install
popd > /dev/null

if [ $USER == "pervez" ]; then
    sclone https://github.com/purcell/emacs.d.git $SEARTIPY_HOME/emacses/purcell.d # purcell emacs
    sclone https://github.com/bbatsov/prelude.git $SEARTIPY_HOME/emacses/prelude.d # batsov prelude
    sclone https://github.com/magnars/.emacs.d.git $SEARTIPY_HOME/emacses/magnars.d --recursive # magnars
fi
