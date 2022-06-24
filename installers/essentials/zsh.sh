# zsh

zsh_ubuntu_install() {
    is_ubuntu || return 1

    slog "Installing zsh"
    sudo apt-get install -y zsh
    sudo apt-get install -y shellcheck
}

zsh_mac_install() {
    is_mac || return 1

    slog "Installing zsh"
    brew install shellcheck
}

oh_my_zsh_install() {
    sclone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

    sclone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
    sclone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
    sclone https://github.com/denysdovhan/spaceship-prompt.git ~/.oh-my-zsh/themes/spaceship-prompt

    sln ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme ~/.oh-my-zsh/themes/spaceship.zsh-theme

    slog "Linking ~/seartipy/dotfiles/oh-my-zsh-zshrc as ~/.zshrc"
    sln ~/seartipy/dotfiles/oh-my-zsh-zshrc ~/.zshrc
}

zgen_install() {
    sclone https://github.com/tarjoilija/zgen.git ~/.zgen

    slog "Linking ~/seartipy/dotfiles/zgen-zshrc as ~/.zshrc"
    sln ~/seartipy/dotfiles/zgen-zshrc ~/.zshrc

    slog "Copying ~/seartipy/dotfiles/templates/zgen-options-local.sh to ~/.zgen-options-local.sh"
    scopy ~/seartipy/dotfiles/templates/zgen-options-local.sh ~/.zgen-options-local.sh

    slog "Copying ~/seartipy/dotfiles/templates/zgen-pre-local.sh to ~/.zgen-pre-local.sh"
    scopy ~/seartipy/dotfiles/templates/zshrc-pre-local.sh ~/.zshrc-pre-local.sh
}

zsh_dotfiles() {
    [ -f ~/seartipy/dotfiles/zgen-zshrc ] || return 1

    slog "Moving ~/.zshrc to $BACKUP_DIR "
    smv ~/.zshrc "$BACKUP_DIR"

    if [ -n "$ZGEN" ]; then
        zgen_install
    else
        oh_my_zsh_install
    fi
}

zsh_install() {
    zsh_ubuntu_install
    zsh_mac_install

    zsh_dotfiles
}

zsh_check() {
    cmd_check zsh shellcheck

    if [ -n "$ZGEN" ]; then
        ln_check ~/seartipy/dotfiles/zgen-zshrc ~/.zshrc
        dir_check ~/.zgen
        file_check ~/.zgen-options-local.sh
        file_check ~/.zshrc-pre-local.sh
    else
        dir_check ~/.oh-my-zsh
        dir_check ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
        dir_check ~/.oh-my-zsh/plugins/zsh-autosuggestions
        dir_check ~/.oh-my-zsh/themes/spaceship-prompt

        ln_check ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh ~/.oh-my-zsh/themes/spaceship.zsh-theme
        ln_check ~/seartipy/dotfiles/oh-my-zsh-zshrc ~/.zshrc
    fi
}
