sclone https://github.com/nojhan/liquidprompt.git $SEARTIPY_HOME/vendors/liquidprompt
safe-append "[[ $- = *i* ]] && source $SEARTIPY_HOME/vendors/liquidprompt/liquidprompt" ~/.bashrc liquidprompt