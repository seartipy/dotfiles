brew install pyenv
brew install pyenv-virtualenv
brew install homebrew/boneyard/pyenv-pip-rehash

if ! pyenv versions | grep anaconda > /dev/null; then
    pyenv install anaconda3-2.2.0
    pyenv global anaconda3-2.2.0
    pip install --upgrade pip
    pip install pylint
    pyenv global system
fi
