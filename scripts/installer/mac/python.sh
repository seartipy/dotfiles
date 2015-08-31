brew install pyenv
brew install pyenv-virtualenv
brew install homebrew/boneyard/pyenv-pip-rehash

if ! pyenv versions | grep anaconda > /dev/null; then
    anacondaversion=`pyenv install --list | grep anaconda | tail -1`
    pyenv install $anacondaversion
    pyenv global $anacondaversion
    pip install --upgrade pip
    pip install pylint
    pyenv global system
fi
