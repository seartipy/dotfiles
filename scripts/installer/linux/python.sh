sclone https://github.com/yyuu/pyenv.git ~/.pyenv
sclone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
sclone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

if ! pyenv versions | grep anaconda > /dev/null; then
    local anaconda=`pyenv install --list | grep anaconda | tail -1`
    pyenv install $anaconda
    pyenv global $anaconda
    pip install --upgrade pip
    pip install pylint
    pyenv global system
fi
