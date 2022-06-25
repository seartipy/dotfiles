xmonad_ubuntu_install() {
    is_ubuntu || return 1

    slog "Installing xmonad"
    sudo apt-get install -y xmonad libghc-xmonad-contrib-dev xmobar suckless-tools rofi
}

xmonad_fix() {
    rm -rf ~/.ghc
    xmonad --recompile
}

xmonad_install() {
    is_linux || return 1

    slog "xmonad setup"

    xmonad_ubuntu_install

    slog "moving ~/.xmonad to $BACKUP_DIR"
    smv ~/.xmonad $BACKUP_DIR

    smd ~/.xmonad

    slog "Linking ~/.seartipy/xmonad.hs to ~/.xmonad/xmonad.hs"
    sln ~/.seartipy/xmonad.hs ~/.xmonad/xmonad.hs

    if has_cmd mate-session; then
        slog "setting xmonad as mate's window manager"
        dconf write /org/mate/desktop/session/required-components/windowmanager "'xmonad'"
    fi

    is_ubuntu || return 1

    xmonad_fix
}

xmonad_check() {
    is_linux || return 1

    cmd_check xmonad dmenu
    is_ubuntu && cmd_check rofi
    ln_check ~/.seartipy/xmonad.hs ~/.xmonad/xmonad.hs
}
