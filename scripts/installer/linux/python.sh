sclone https://github.com/yyuu/pyenv.git ~/.pyenv
sclone https://github.com/yyuu/pyenv-pip-rehash.git ~/.pyenv/plugins/pyenv-pip-rehash
sclone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv

if ! pyenv versions | grep anaconda > /dev/null; then
    anacondaversion=`pyenv install --list | grep anaconda | tail -1`
    pyenv install $anacondaversion
    pyenv global $anacondaversion
    pip install --upgrade pip
    pip install pylint
    pyenv global system
fi
