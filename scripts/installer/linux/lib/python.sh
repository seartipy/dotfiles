sclone https://github.com/yyuu/pyenv.git ~/.pyenv
if ! grep PYENV_ROOT ~/.zshenv > /dev/null; then
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshenv
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshenv
    echo 'eval "$(pyenv init -)"' >> ~/.zshenv
fi

sclone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash

sclone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
if ! grep virtualenv-init ~/.zshenv > /dev/null; then
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshenv
fi

source ~/.zshenv

if ! pyenv versions | grep anaconda > /dev/null; then
    pyenv install anaconda3-2.2.0
    pyenv global anaconda3-2.2.0
    pip install --upgrade pip
    pip install pylint
    pyenv global system
fi
