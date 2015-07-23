echo "=================Install Xcode...=================="

clang++ -v

echo "=========Install homebrew and caskroom...=========="

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

echo "===============Install packages...================="

brew tap railwaycat/emacsmacport
brew update && brew upgrade
brew install emacs-mac wget tree trash tmux fasd the_silver_searcher editorconfig ctags gibo leiningen
brew install aspell --with-lang-en
brew cask install spectacle smartgit kdiff3
brew cleanup && brew cask cleanup

echo "===============Installing dotfiles...==============="

git clone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles
git clone https://github.com/pervezfunctor/emacs.d.git ~/housem.d
ln -s ~/dotfiles/common/tmux.conf ~/.tmux.conf
cp ~/dotfiles/common/gitconfig ~/.gitconfig

echo "================Installing emacs...================"

git clone --recursive https://github.com/syl20bnr/spacemacs ~/spacemacs
ln -s ~/spacemacs/ ~/.emacs.d
ln -s ~/dotfiles/common/spacemacs ~/.spacemacs
osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'
tic -o ~/.terminfo /usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.8/share/emacs/24.5/etc/e/eterm-color.ti

echo "Opening emacs, Press Ctrl+X Ctrl+C to exit after installation"

emacs&

echo "===============Installing clojure...==============="

mkdir ~/.lein
ln -s ~/dotfiles/common/profiles.clj ~/.lein/profiles.clj

echo "=================Installing zsh...=================="

git clone https://github.com/zsh-users/antigen.git ~/antigen
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup
ln -s ~/dotfiles/common/zshrc ~/.zshrc
chsh -s /bin/zsh

echo "======Starting clojure repl(use Ctrl+D to exit)===="

lein repl

echo "=======Installation done. Reboot your system======="
