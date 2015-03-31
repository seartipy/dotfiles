export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="avit"

plugins=(gitfast git-extras command-not-found lein node npm rails ruby rvm sbt scala sublime terminator tmux vagrant autojump bower bundler cabal coffee common-aliases dircycle dirhistory fasd gem)

source $ZSH/oh-my-zsh.sh

[ -s "$HOME/.nvm/nvm.sh" ] && . "$HOME/.nvm/nvm.sh"

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

. /Users/pervez/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export PATH=$HOME/.cabal/bin:/user/local/bin:$PATH:$HOME/bin

export JAVA_HOME=`/usr/libexec/java_home -v 1.7`

alias brew-upgrade="brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup"

alias emacs="open /Applications/Emacs.app"
alias v='f -e "open /Applications/Emacs.app"'
