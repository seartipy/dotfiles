export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="bira"

plugins=(gitfast git-extras command-not-found lein node npm rails ruby rvm sbt scala sublime terminator tmux vagrant autojump bower bundler cabal coffee common-aliases debian dircycle dirhistory fasd gem)

source $ZSH/oh-my-zsh.sh

[ -s "/home/pervez/.nvm/nvm.sh" ] && . "/home/pervez/.nvm/nvm.sh" # This loads nvm

. /home/pervez/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true # nvm


alias tmux="tmux -u"

export JAVA_HOME="/usr/lib/jvm/java-7-oracle"
export JDK_HOME="/usr/lib/jvm/java-7-oracle"

export PATH=$PATH:$HOME/bin
