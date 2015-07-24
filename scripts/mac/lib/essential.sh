brew install wget tree tmux fasd the_silver_searcher editorconfig ctags gibo gpg kdiff3 smartgit git-extras emacs-mac unrar p7zip trash coreutils
brew install aspell --with-lang-en
brew install macvim --override-system-vim --with-lua --with-luajit
brew linkapps macvim

# dotfiles

git clone https://github.com/pervezfunctor/dotfiles.git
mkdir ~/bin

#### bash

git clone https://github.com/nojhan/liquidprompt.git ~/liquidprompt
echo "[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt" >> ~/.bash_profile

# zsh

git clone https://github.com/zsh-users/antigen.git
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup
ln -s ~/dotfiles/common/zshrc ~/.zshrc
ln -s ~/dotfiles/common/tmux.conf ~/.tmux.conf

#### git

cp ~/dotfiles/common/gitconfig ~/.gitconfig

# vim

curl http://j.mp/spf13-vim3 -L -o - | sh
osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/Cellar/macvim/7.4-76/MacVim.app" at POSIX file "/Applications"'

# emacs

git clone --recursive https://github.com/syl20bnr/spacemacs ~/spacemacs
git clone https://github.com/pervezfunctor/emacs.d.git ~/housem.d
ln -s ~/housem.d ~/.emacs.d
osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/opt/emacs-mac/Emacs.app" at POSIX file "/Applications"'
tic -o ~/.terminfo /usr/local/Cellar/emacs-mac/emacs-24.5-z-mac-5.8/share/emacs/24.5/etc/e/eterm-color.ti
