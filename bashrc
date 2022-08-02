#! /bin/bash

[ -s ~/.seartipy/shellrc ] && source ~/.seartipy/shellrc


has_cmd starship && eval "$(starship init bash)"
