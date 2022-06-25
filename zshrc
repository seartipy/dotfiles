[ -s ~/seartipy/dotfiles/shellrc ] && source ~/seartipy/dotfiles/shellrc

[[ $- == *i* ]] || return 0

if ! [ -d ~/.oh-my-zsh ]; then
  source ~/seartipy/dotfiles/oh-my-zsh-zshrc
else
  source ~/seartipy/dotfiles/zgen-zshrc
fi
