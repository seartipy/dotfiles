#! /usr/bin/env bash

{

python_mac_install() {
    is_mac || return 1

    slog "Installing python packages"
    brew install pyenv
    brew install pyenv-virtualenv
}

python_linux_install() {
    is_linux || return 1

    sclone  https://github.com/yyuu/pyenv.git ~/.pyenv
    sclone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
}

python_install() {
    python_mac_install
    python_linux_install

    export PYENV_ROOT="$HOME/.pyenv"
    path_export "$PYENV_ROOT/bin"

    has_cmd pyenv || return 1

    if ! pyenv versions | grep anaconda > /dev/null; then
        slog "Installing anaconda"
        local anacondaversion=`pyenv install --list | grep anaconda | tail -1`
        pyenv install $anacondaversion
    fi
}

python_check() {
    export PYENV_ROOT="$HOME/.pyenv"
    path_export "$PYENV_ROOT/bin"

    cmd_check pyenv

    is_mac && cmd_check pyenv-virtualenv

    is_linux && dir_check ~/.pyenv ~/.pyenv/plugins/pyenv-virtualenv

    has_cmd pyenv || return 1

    if ! pyenv versions | grep anaconda > /dev/null; then
        warn "anaconda not installed"
    fi
}

}
