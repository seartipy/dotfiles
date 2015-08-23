sclone https://github.com/nojhan/liquidprompt.git $SEARTIPY_HOME/vendors/liquidprompt
[ -e ~/.bash_profile ] && mv -b ~/.bash_profile ~/.bash_profile-backup > /dev/null
sln ~/SEARTIP_HOME/dotfiles/common/bashrc ~/.bash_profile
