sclone https://github.com/yyuu/pyenv.git ~/.pyenv
sclone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
sclone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

if ! pyenv versions | grep anaconda > /dev/null; then
    pyenv install anaconda3-2.2.0
    pyenv global anaconda3-2.2.0
    pip install --upgrade pip
    pip install pylint
    pyenv global system
fi
