# upgrade

seartipy-gitup() {
    cd "$1" 2> /dev/null || return 1

    if has_cmd git-up; then
        git-up
    else
        git pull --ff-only
    fi
}

seartipy_upgrade_emacs() {
    seartipy-gitup ~/seartipy/emacses/emacsd
    seartipy_emacs_upgrade
}

seartipy_upgrade_dotfiles() {
    seartipy-gitup ~/.seartipy
    seartipy-gitup ~/seartipy/dotdotfiles
}

seartipy_upgrade_mean() {
    upgrade
    seartipy_upgrade_dotfiles
    has_cmd zgen && zgen selfupdate && zgen update
    has_cmd zplug && zplug update
}

seartipy_nvm_dist_upgrade() {
    has_cmd nvm || return 1

    cd "$NVM_DIR" && git fetch origin && git checkout "$(git describe --abbrev=0 --tags)"
    cd
    source "$NVM_DIR/nvm.sh"

    nvm install node --reinstall-packages-from=node
    nvm alias default node
}

seartipy_conda_upgrade_all() {
    conda update --all
}

# http://stackoverflow.com/questions/2720014/upgrading-all-packages-with-pip
seartipy_pip_upgrade_all() {
    pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U
}

seartipy_upgrade_all() {
    if [ -d ~/.cask ]; then
        srm ~/.cask
        srm ~/seartipy/emacses/emacsd
        srm ~/.emacs.d
        git clone https://pervezfunctor@gitlab.com/seartipy/emacsd.git ~/seartipy/emacses/emacsd
        sln ~/seartipy/emacses/emacsd ~/.emacs.d
    fi

    seartipy_upgrade_mean
    has_cmd sbt && cd ~/programs/scala/scala-starter 2> /dev/null && sbt console -batch
    has_cmd lein && cd ~/programs/clojure/clojure-starter 2> /dev/null && lein
    cd && has_cmd npm && npm update -g
    cd && has_cmd cabal && cabal update
    cd && has_cmd stack && stack update
    cd && has_cmd stack && stack update
    cd && has_cmd pyenv && pyenv rehash
}

alias upa=seartipy_upgrade_all
alias upm=seartipy_upgrade_mean
alias ups=upgrade
alias upe=seartipy_upgrade_emacs
alias upd=seartipy_upgrade_dotfiles
