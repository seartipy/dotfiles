# python

brew install pyenv pyenv-virtualenv homebrew/boneyard/pyenv-pip-rehash
echo 'eval "$(pyenv init -)"' >> ~/.zshenv
git clone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshenv

exec $SHELL
pyenv install anaconda3-2.2.0
pyenv global anaconda3-2.2.0
pip install --upgrade pip
pip install pylint
pyenv global system
