# sclone https://github.com/nojhan/liquidprompt.git $SEARTIPY_HOME/vendors/liquidprompt
# smv ~/.bash_profile ~/.bash_profile-backup
# sln $SEARTIPY_HOME/dotfiles/common/bashrc ~/.bash_profile

if ! grep .bash_profile ~/.bashrc > /dev/null; then
    echo "[ -f ~/.bash_profile ] && source ~/.bash_profile" >> ~/.bashrc
fi
