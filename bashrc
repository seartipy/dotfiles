#! /bin/bash

[ -d ~/.liquidprompt ] || git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt

[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

source ~/seartipy/dotfiles/shellrc

# >>> coursier install directory >>>
export PATH="$PATH:/home/pervez/.local/share/coursier/bin"
# <<< coursier install directory <<<
