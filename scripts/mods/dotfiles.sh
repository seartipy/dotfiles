
# dotfiles

clone_dotfiles() {
    sclone https://github.com/seartipy/dotfiles.git ~/.seartipy
    [ -d ~/.seartipy ] || return 1

    pre_dir_check ~/.seartipy
}

tmux_dotfiles() {
    [ -f ~/.seartipy/tmux.conf ] || return 1

    slog "Moving ~/.tmux.conf to $BACKUP_DIR"
    smv ~/.tmux.conf "$BACKUP_DIR"

    slog "Linking ~/.seartipy/tmux.conf to ~/.tmux.conf"
    sln ~/.seartipy/tmux.conf ~/.tmux.conf

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

    slog "Linking ~/.seartipy/zgen-zshrc as ~/.zshrc"
    sln ~/.seartipy/zshrc ~/.zshrc
}

zsh_dotfiles() {
    [ -f ~/.seartipy/zgen-zshrc ] || return 1

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
    [ -f ~/.seartipy/bashrc ] || return 1

    slog "Moving ~/.bash_profile, ~/.bashrc to $BACKUP_DIR"
    smv ~/.bash_profile $BACKUP_DIR
    smv ~/.bashrc "$BACKUP_DIR"

    sln ~/.seartipy/bashrc ~/.bash_profile
    sln ~/.seartipy/bashrc ~/.bashrc
}

linux_bash_dotfiles() {
    is_linux || return 1
    [ -f ~/.seartipy/bashrc ] || return 1

    slog "Moving ~/.bash_profile to $BACKUP_DIR"
    smv ~/.bash_profile "$BACKUP_DIR"
    sln ~/.seartipy/bashrc ~/.bash_profile

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
    [ -n "$DOTFILES" ] || return 0

    clone_dotfiles

    if [ -n "$ZGEN" ] || [ -n "$OHMYZSH" ]; then
        zsh_install
    fi
    [ -n "$BASH" ] && bash_install
    [ -n "$TMUX" ] && tmux_dotfiles
}

bash_check() {
    is_mac && ln_check ~/.seartipy/bashrc ~/.bashrc
    ln_check ~/.seartipy/bashrc ~/.bash_profile

    if is_linux && ! grep .bash_profile ~/.bashrc > /dev/null; then
        warn "~/.bash_profile not sourced in ~/.bashrc"
    fi
    dir_check ~/.liquidprompt
}

zsh_check() {
    cmd_check zsh shellcheck
    ln_check ~/.seartipy/zshrc ~/.zshrc

    [ -n "$ZGEN" ] && dir_check ~/.zgen

    if [ -n "$OHMYZSH" ]; then
        dir_check ~/.oh-my-zsh
        dir_check ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
        dir_check ~/.oh-my-zsh/plugins/zsh-autosuggestions
        dir_check ~/.oh-my-zsh/themes/spaceship-prompt
        ln_check ~/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh ~/.oh-my-zsh/themes/spaceship.zsh-theme
    fi
}

dotfiles_check() {
    [ -n "$DOTFILES" ] || return 0

    dir_check ~/.seartipy

    if [ -n "$TMUX" ]; then
        ln_check ~/.seartipy/tmux.conf ~/.tmux.conf
        dir_check ~/.tmux/plugins/tpm
    fi

    if [ -n "$OHMYZSH" ] || [ -n "$ZGEN" ]; then 
        zsh_check
    fi

    [ -n "$BASH" ] && bash_check
}

dotfiles_setup() {
    BASH="bash"
    TMUX="tmux"
    ZGEN="zgen"
    OHMYZSH=""

    while [[ $# -gt 0 ]]; do
        case $1 in
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

    slog "Selecting $BASH $ZGEN $TMUX $OHMYZSH"
}
