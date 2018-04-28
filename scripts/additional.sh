#
# additional

docker_ubuntu_install() {
    is_ubuntu || return 1
    has_cmd docker && return 1

    sudo apt-get install -y apt-transport-https ca-certificates
    sudo systemctl enable docker
    sudo usermod -aG docker "$USER"
}

icdiff_mac_install() {
    is_mac || return 1
    brew install icdiff
}

icdiff_linux_install() {
    is_linux || return 1

    has_cmd icdiff || curl -L https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/icdiff > ~/bin/icdiff && chmod +x ~/bin/icdiff

    has_cmd git-icdiff || curl -L https://raw.githubusercontent.com/jeffkaufman/icdiff/release-1.8.1/git-icdiff > ~/bin/git-icdiff && chmod +x ~/bin/git-icdiff
}

icdiff_install() {
    icdiff_mac_install
    icdiff_linux_install
}

additional_mac_install() {
    is_mac || return 1

    slog "Installing additional packages"
    brew cask install google-chrome dash android-file-transfer transmission macdown vlc karabiner seil spectacle skype gitup discord alfred typora
    brew install jq httpie icdiff
    brew cask install betterzipql qlcolorcode qlimagesize qlmarkdown qlprettypatch qlstephen quicklook-csv quicklook-json webpquicklook xquartz suspicious-package
    brew install youtube-dl
    if ! has_cmd vmware-user-suid-wrapper; then
        brew cask install virtualbox virtualbox-extension-pack
    fi
}

typora_install() {
    is_ubuntu || return 1

    add_typora_ppa
    sudo apt-get update

    sudo apt-get install typora
}

additional_ubuntu_install() {
    is_ubuntu || return 1

    add_webupd8_ppa
    ubuntu_update

    slog "Installing additional"

    sudo apt-get install -y jq httpie

    if ! has_cmd vmware-user-suid-wrapper; then
        sudo apt-get install -y virtualbox vlc
        sudo apt-get install -y youtube-dl
        docker_ubuntu_install
    fi

    typora_install
}

additional_install() {
    additional_mac_install
    additional_ubuntu_install

    icdiff_install
}

additional_check() {
    if ! has_cmd vmware-user-suid-wrapper; then
        is_mac && cmd_check virtualbox
        brew_cask_check virtualbox-extension-pack
        is_ubuntu && cmd_check docker
    fi

    is_mac && brew_cask_check dash android-file-transfer transmission macdown vlc karabiner seil spectacle skype gitup discord alfred betterzipql qlcolorcode qlimagesize qlmarkdown qlprettypatch qlstephen quicklook-csv quicklook-json webpquicklook xquartz suspicious-package

    cmd_check icdiff jq http

    is_linux || return 0
    cmd_check jq http git-icdiff vlc youtube-dl
    has_cmd vmware-user-suid-wrapper || cmd_check virtualbox
}
