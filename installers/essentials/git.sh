{

git_mac_install() {
    is_mac || return 1

    slog "Installing git packages"
    brew install git-extras

    is_gui || return 1
    brew install smartgit
    brew install github
    brew install gitup
}

git_ubuntu_install() {
    is_ubuntu || return 1

    slog "Installing git"
    sudo apt-get install -y git
    sudo apt-get install -y git-extras
    is_gui || return 1

    sudo deb-get install github-desktop
    sudo apt-get install -y kdiff3
}

git_install() {
    git_mac_install
    git_ubuntu_install

    brew install gh

    scopy ~/seartipy/dotfiles/templates/gitconfig ~/.gitconfig
}

}

git_check() {
    cmd_check git git-extras
    is_ubuntu && cmd_check kdiff3
    is_mac && brew_check smartgit github

    file_check ~/.gitconfig
}
