# bash

mac_bash_dotfiles() {
    is_mac || return 1
    [ -f ~/seartipy/dotfiles/bashrc ] || return 1

    slog "Moving ~/.bash_profile, ~/.bashrc to $BACKUP_DIR"
    smv ~/.bash_profile $BACKUP_DIR
    smv ~/.bashrc "$BACKUP_DIR"

    sln ~/seartipy/dotfiles/bashrc ~/.bash_profile
    sln ~/seartipy/dotfiles/bashrc ~/.bashrc
}

linux_bash_dotfiles() {
    is_linux || return 1
    [ -f ~/seartipy/dotfiles/bashrc ] || return 1

    slog "Moving ~/.bash_profile to $BACKUP_DIR"
    smv ~/.bash_profile "$BACKUP_DIR"
    sln ~/seartipy/dotfiles/bashrc ~/.bash_profile

    if ! grep .bash_profile ~/.bashrc > /dev/null; then
        echo "[ -f ~/.bash_profile ] && source ~/.bash_profile" >> ~/.bashrc
    fi
}

bash_install() {
    mac_bash_dotfiles
    linux_bash_dotfiles

    sclone https://github.com/nojhan/liquidprompt.git ~/.liquidprompt
}

bash_check() {
    is_mac && ln_check ~/seartipy/dotfiles/bashrc ~/.bashrc
    ln_check ~/seartipy/dotfiles/bashrc ~/.bash_profile

    if is_linux && ! grep .bash_profile ~/.bashrc > /dev/null; then
        warn "~/.bash_profile not sourced in ~/.bashrc"
    fi
    dir_check ~/.liquidprompt
}
