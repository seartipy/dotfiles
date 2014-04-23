export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=(gitfast git-extras command-not-found lein node npm rails ruby rvm sbt scala sublime terminator tmux vagrant autojump bower bundler cabal coffee common-aliases debian dircycle dirhistory fasd gem)

source $ZSH/oh-my-zsh.sh

[ -s "/home/pervez/.nvm/nvm.sh" ] && . "/home/pervez/.nvm/nvm.sh" # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

. /home/pervez/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true # nvm

alias nh="node --harmony"
alias mh="mocha --harmony"
alias tmux="tmux -u"
alias gh="node --harmony /home/pervez/.nvm/v0.11.12/bin/gulp"
