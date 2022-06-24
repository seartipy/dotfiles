
# dotfiles

clone_dotfiles() {
    sclone https://gitlab.com/seartipy/dotfiles.git ~/seartipy/dotfiles
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

dotfiles_install() {
    clone_dotfiles

    tmux_dotfiles
}

dotfiles_check() {
    dir_check ~/seartipy/dotfiles
    ln_check ~/seartipy/dotfiles/tmux.conf ~/.tmux.conf
    dir_check ~/.tmux/plugins/tpm
}
