font_exists() {
    if is_mac; then
        is_mac && ls ~/Library/Fonts 2> /dev/null | grep "$1" > /dev/null
    else
        (ls ~/.local/share/fonts 2> /dev/null | grep "$1" > /dev/null) || (ls ~/.fonts 2> /dev/null | grep "$1" > /dev/null)
    fi
}

mononoki_font() {
    if ! font_exists "mononoki"; then
        slog "Installing mononoki fonts"

        srm /tmp/mononoki.zip
        wget  --quiet -O /tmp/mononoki.zip https://github.com/madmalik/mononoki/releases/download/1.2/mononoki.zip
        srm /tmp/seartipy-mononoki-fonts
        unzip /tmp/mononoki.zip -d /tmp/seartipy-mononoki-fonts

        is_mac && cp /tmp/seartipy-mononoki-fonts/*.ttf ~/Library/Fonts

        if is_linux; then
            smd ~/.fonts
            cp /tmp/seartipy-mononoki-fonts/*.ttf ~/.fonts
            fc-cache -f ~/.fonts
        fi

        rm -f /tmp/mononoki.zip
        rm -rf /tmp/seartipy-mononoki-fonts
    fi
}

powerline_fonts() {
    if ! font_exists "Powerline"; then
        slog "Installing powerline patched fonts"
        fclone https://github.com/powerline/fonts.git /tmp/seartipy-powerline-fonts
        cd /tmp/seartipy-powerline-fonts && ./install.sh
        cd
        rm -rf /tmp/seartipy-powerline-fonts
    fi
}

firacode_font() {
    if is_ubuntu; then
        sudo apt-get install -y fonts-firacode
    elif is_mac; then
        brew tap homebrew/cask-fonts
        brew cask install font-fira-code
    fi
}

fonts_install() {
    powerline_fonts
    mononoki_font
    firacode_font
}

fonts_check() {
    font_exists "Powerline" || warn "powerline fonts not installed"
    font_exists "mononoki" > /dev/null || warn "mononoki font not installed"
    font_exists "firacode" > /dev/null || warn "firacode font not installed"
}
