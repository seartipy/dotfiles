
# dotfiles

clone_dotfiles() {
    sclone https://github.com/seartipy/dotfiles.git ~/seartipy/dotfiles
    [ -d ~/seartipy/dotfiles ] || return 1

    pre_dir_check ~/seartipy/dotfiles
}

tmux_dotfiles() {
    [ -f ~/seartipy/dotfiles/tmux.conf ] || return 1

    slog "Moving ~/.tmux.conf to $BACKUP_DIR"
    smv ~/.tmux.conf "$BACKUP_DIR"

    slog "Linking ~/seartipy/dotfiles/tmux.conf to ~/.tmux.conf"
    sln ~/seartipy/dotfiles/tmux.conf ~/.tmux.conf

    smd ~/.tmux/plugins
    sclone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

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

zgen_install() {
    sclone https://github.com/tarjoilija/zgen.git ~/.zgen

    slog "Linking ~/seartipy/dotfiles/zgen-zshrc as ~/.zshrc"
    sln ~/seartipy/dotfiles/zshrc ~/.zshrc
}

zsh_dotfiles() {
    [ -f ~/seartipy/dotfiles/zgen-zshrc ] || return 1

    slog "Moving ~/.zshrc to $BACKUP_DIR "
    smv ~/.zshrc "$BACKUP_DIR"

    [ -n "$ZGEN" ] && zgen_install
    [ -n "$OHMYZSH" ] && oh_my_zsh_install
}

zsh_install() {
    zsh_ubuntu_install
    zsh_mac_install

    zsh_dotfiles
}

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

dotfiles_install() {
    [ -n "$DOTFILES"] || return 0

    clone_dotfiles

    [ -n "$ZSH" ] && zsh_install
    [ -n "$BASH" ] && bash_install
    [ -n "$TMUX" ] && tmux_dotfiles
}

bash_check() {
    is_mac && ln_check ~/seartipy/dotfiles/bashrc ~/.bashrc
    ln_check ~/seartipy/dotfiles/bashrc ~/.bash_profile

    if is_linux && ! grep .bash_profile ~/.bashrc > /dev/null; then
        warn "~/.bash_profile not sourced in ~/.bashrc"
    fi
    dir_check ~/.liquidprompt
}

zsh_check() {
    cmd_check zsh shellcheck
    n_check ~/seartipy/dotfiles/zshrc ~/.zshrc

    [ -n "$ZGEN"] && dir_check ~/.zgen

    if [ -n "$OHMYZSH" ]; then
        dir_check ~/.oh-my-zsh
        dir_check ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
        dir_check ~/.oh-my-zsh/plugins/zsh-autosuggestions
        dir_check ~/.oh-my-zsh/themes/spaceship-prompt
        ln_check ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh ~/.oh-my-zsh/themes/spaceship.zsh-theme
    fi
}

dotfiles_check() {
    dir_check ~/seartipy/dotfiles

    if [ -n "$TMUX" ]; then
        ln_check ~/seartipy/dotfiles/tmux.conf ~/.tmux.conf
        dir_check ~/.tmux/plugins/tpm
    fi

    [ -n "$ZSH" ] && zsh_check
    [ -n "$BASH" ] && bash_check
}

dotfiles_setup() {
    DOTFILES="dotfiles"
    BASH="bash"
    ZGEN="zgen"
    TMUX="tmux"
    OHMYZSH=""

    while [[ $# -gt 0 ]]; do
        case $1 in
            nodotfiles)
                DOTFILES=""
                shift
                ;;
            nobash)
                BASH=""
                shift
                ;;
            nozgen)
                ZGEN=""
                shift
                ;;
            notmux)
                TMUX=""
                shift
                ;;
            ohmyzsh)
                OHMYZSH="ohmyzsh"
                ZGEN=""
                shift
                ;;
        esac
    done
}
