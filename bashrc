#! /bin/bash

[ -d ~/.liquidprompt ] || git clone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt

[[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

source ~/.seartipy/shellrc
