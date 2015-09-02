#node
[ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"

#rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#python
if [ $(which pyenv) ]; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
