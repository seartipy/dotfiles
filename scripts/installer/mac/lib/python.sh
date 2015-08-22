brew install pyenv pyenv-virtualenv homebrew/boneyard/pyenv-pip-rehash

if ! grep PYENV_ROOT ~/.zshenv > /dev/null; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
    echo 'eval "$(pyenv init -)"' >> ~/.zshenv
fi

if ! grep virtualenv-init ~/.zshenv > /dev/null; then
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshenv
fi

source ~/.zshenv

pyenv install anaconda3-2.2.0
pyenv global anaconda3-2.2.0
pip install --upgrade pip
pip install pylint
pyenv global system
