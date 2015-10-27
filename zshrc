[ -s ~/.zshrc-pre.local ] && source ~/.zshrc-pre.local

source ~/seartipy/vendors/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle gitfast
antigen bundle git-extras
antigen bundle github
antigen bundle jsontools

antigen bundle command-not-found
antigen bundle autojump
antigen bundle common-aliases
antigen bundle dircycle
antigen bundle dirhistory

antigen bundle lein
antigen bundle sbt
antigen bundle scala
antigen bundle cabal
antigen bundle python
antigen bundle ruby
antigen bundle pip
antigen bundle coffee

# antigen bundle atom
antigen bundle sublime
antigen bundle web-search

antigen bundle fasd

antigen bundle zsh-users/zsh-history-substring-search

# fix for using zsh inside emacs
if [ -n "$INSIDE_EMACS" ]; then
    antigen theme robbyrussell
else
    antigen bundle nojhan/liquidprompt
    antigen bundle zsh-users/zsh-syntax-highlighting
fi

antigen apply

source ~/seartipy/dotfiles/shellrc

if [[ "$USER" == "pervez" ]] && [[ $- == *i* && $- == *m* ]] && ! [[ -n "$INSIDE_EMACS" ]]; then
    [[ -z "$TMUX" ]] && exec tmux
fi

[ -s ~/.zshrc-post.local ] && source ~/.zshrc-post.local
