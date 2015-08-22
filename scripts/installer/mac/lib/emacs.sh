brew tap railwaycat/emacsmacport

brew install emacs-mac
brew install aspell --with-lang-en
brew install editorconfig the_silver_searcher

sclone https://github.com/syl20bnr/spacemacs $SEARTIPY_HOME/emacses/spacemacs.d --recursive # spacemacs
sln $SEARTIPY_HOME/dotfiles/common/spacemacs ~/.spacemacs

sclone https://github.com/pervezfunctor/emacs.d.git $SEARTIPY_HOME/emacses/housem.d # my emacs
sln $SEARTIPY_HOME/emacses/housem.d ~/.emacs.d

brew install cask
pushd .
cd $SEARTIPY_HOME/emacses/housem.d && ~/.cask/bin/cask install
popd > /dev/null

sclone https://github.com/purcell/emacs.d.git $SEARTIPY_HOME/emacses/purcell.d # purcell emacs
sclone https://github.com/bbatsov/prelude.git $SEARTIPY_HOME/emacses/prelude.d # batsov prelude
sclone https://github.com/magnars/.emacs.d.git $SEARTIPY_HOME/emacses/magnars.d --recursive # magnars

osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'
tic -o ~/.terminfo /usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.8/share/emacs/24.5/etc/e/eterm-color.ti
