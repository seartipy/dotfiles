sudo apt-get install zsh
git clone https://github.com/zsh-users/antigen.git $SEARTIPY_HOME/vendors/antigen
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup
ln -s $SEARTIPY_HOME/dotfiles/common/zshrc ~/.zshrc
ln -s $SEARTIPY_HOME/dotfiles/common/tmux.conf ~/.tmux.conf
