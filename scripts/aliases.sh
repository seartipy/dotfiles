if [[ "$OSTYPE" == "linux-gnu" ]]; then
    #haskell
    alias cabal="cabal-1.22"

    alias upgrade="sudo apt-get update && sudo apt-get upgrade -y"
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
    alias open="xdg-open"
    alias trash=trash-put

    alias tmux="tmux -u -2" #force tmux to use unicode and 256 colors

    #to support xterm key bindings in emacs
    alias e="TERM=xterm-256color emacs -nw"

elif [[ "$OSTYPE" == "darwin"* ]]; then
    alias upgrade="brew update && brew upgrade"
fi
