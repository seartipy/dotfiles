[[ $- != *i* ]] && return
if [ -n "$INSIDE_EMACS" ] && [[ -z "$TMUX" ]] && exec tmux

