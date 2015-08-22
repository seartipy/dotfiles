sudo apt-get install -y zsh
sclone https://github.com/zsh-users/antigen.git $SEARTIPY_HOME/vendors/antigen
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup > /dev/null
sln $SEARTIPY_HOME/dotfiles/common/zshrc ~/.zshrc
sln $SEARTIPY_HOME/dotfiles/common/tmux.conf ~/.tmux.conf
