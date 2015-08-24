brew tap railwaycat/emacsmacport

brew install emacs-mac
brew install aspell --with-lang-en
brew install editorconfig
brew install the_silver_searcher

sclone https://github.com/syl20bnr/spacemacs $SEARTIPY_HOME/emacses/spacemacs.d --recursive # spacemacs
sln $SEARTIPY_HOME/dotfiles/common/spacemacs ~/.spacemacs

sclone https://github.com/pervezfunctor/emacs.d.git $SEARTIPY_HOME/emacses/housem.d # my emacs
brew install cask
cd $SEARTIPY_HOME/emacses/housem.d && cask install

smv ~/.emacs.d ~/.emacs.d-backup
if [ $USER == "pervez" ]; then
    sln $SEARTIPY_HOME/emacses/housem.d ~/.emacs.d

    sclone https://github.com/purcell/emacs.d.git $SEARTIPY_HOME/emacses/purcell.d # purcell emacs
    sclone https://github.com/bbatsov/prelude.git $SEARTIPY_HOME/emacses/prelude.d # batsov prelude
    sclone https://github.com/magnars/.emacs.d.git $SEARTIPY_HOME/emacses/magnars.d --recursive # magnars
else
    sln $SEARTIPY_HOME/emacses/spacemacs.d ~/.emacs.d
fi

osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'
emacsversion=`ls /usr/local/Cellar/emacs-mac`
tic -o ~/.terminfo /usr/local/Cellar/emacs-mac/${emacsversion}/share/emacs/24.5/etc/e/eterm-color.ti
