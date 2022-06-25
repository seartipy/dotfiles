[ -s ~/.seartipy/shellrc ] && source ~/.seartipy/shellrc

[[ $- == *i* ]] || return 0

if ! [ -d ~/.oh-my-zsh ]; then
  source ~/.seartipy/oh-my-zsh-zshrc
else
  source ~/.seartipy/zgen-zshrc
fi
