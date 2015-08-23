brew install pyenv pyenv-virtualenv homebrew/boneyard/pyenv-pip-rehash

source $SEARTIPY_HOME/dotfiles/common/zshenv
if ! pyenv versions | grep anaconda > /dev/null; then
    pyenv install anaconda3-2.2.0
    pyenv global anaconda3-2.2.0
    pip install --upgrade pip
    pip install pylint
    pyenv global system
fi
