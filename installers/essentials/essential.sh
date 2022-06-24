# essential

ubuntu_update() {
    is_ubuntu || return 1

    slog "Updating ubuntu packages"
    if ! sudo apt-get update; then
        err_exit "apt-get update failed, quitting"
    fi
}

ubuntu_upgrade() {
    is_ubuntu || return 1

    slog "Upgrading ubuntu packages"
    if ! sudo apt-get upgrade -y; then
        err_exit "apt-get upgrade failed, quitting"
    fi
}

deb_get_install() {
    slog "Installing deb-get"
    has_cmd deb-get && return 0

    curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get

    sudo deb-get install gh

    is_gui || return 1

    sudo deb-get install zoom
    # sudo deb-get install insomnia
}

linux_brew_install() {
    slog "Installing homebrew(linux)"

    if ! has_cmd brew; then
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	    slog "Setting up brew path"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
}

essential_ubuntu_install() {
    is_ubuntu || return 1
    pre_cmd_check apt-get

    sudo apt-get install -y software-properties-common
    sudo apt-get install -y apt-transport-https
    sudo apt-get install -y ca-certificates

    pre_cmd_check debconf-set-selections add-apt-repository apt-key wget

    ubuntu_update
    ubuntu_upgrade

    sudo apt-get install -y curl
    pre_cmd_check curl

    deb_get_install
    linux_brew_install
    pre_cmd_check brew deb-get

    slog "Installing essential packages"
    sudo apt-get install -y wget
    sudo apt-get install -y git
    sudo apt-get install -y trash-cli
    sudo apt-get install -y tree
    sudo apt-get install -y xsel
    sudo apt-get install -y xclip
    sudo apt-get install -y bat
    sudo apt-get install -y fzf
    sudo apt-get install -y silversearcher-ag
    sudo apt-get install -y ripgrep
    sudo apt-get install -y p7zip
    sudo apt-get install -y dconf-cli
    sudo apt-get install -y build-essential
    sudo apt-get install -y tmux
    sudo apt-get install -y unar
    sudo apt-get install -y unzip
    sudo apt-get install -y libzmq3-dev
    sudo apt-get install -y pkg-config
    sudo apt-get install -y zip
    sudo apt-get install -y gawk
    sudo apt-get install -y urlview
    sudo apt-get install -y "linux-headers-$(uname -r)"
    sudo apt-get install -y gnome-keyring
    sudo apt-get install -y fasd
    sudo apt-get install -y fonts-cascadia-code

    is_gui || return 1

    sudo apt-get install -y firefox
    sudo apt-get install -y exfat-utils
    sudo apt-get install -y exfat-fuse

    sudo deb-get install google-chrome-stable
}

essential_mac_install() {
    is_mac || return 1

    slog "Installing rosetta"
    softwareupdate --rosetta --agree-to-license

    if ! has_cmd brew; then
        slog "Installing homebrew"
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    pre_cmd_check brew

    slog "Upgrading brew packages"
    brew update && brew upgrade

    slog "Installing brew packages"
    brew install wget
    brew install trash
    brew install tree
    brew install fasd
    brew install bat
    brew install fzf
    brew install unar
    brew install p7zip
    brew install the_silver_searcher
    brew install ripgrep
    brew install coreutils
    brew install tmux
    brew install gpg
    brew install zeromq
    brew install pkg-config
    brew install gawk
    brew install urlview
    brew install gh

    brew install iterm2
    brew install google-chrome
}


docker_ubuntu_install() {
    slog "Installing docker"
    is_ubuntu || return 1

    sudo deb-get install docker-ce
    sudo deb-get install docker-desktop
}

docker_mac_install() {
    slog "Installing docker"
    is_mac || return 1

    brew install docker
}

docker_install() {
    docker_ubuntu_install
    docker_mac_install
}

brew_packages_install() {
    brew install lsd
    brew install duf
    brew install git-delta
    brew install broot
    brew install fd
    brew install bottom
    brew install procs

    # brew install hyperfine
    # brew install httpie
    # brew install curlie
    # brew install fzf
    # brew install tldr
    # brew install exa
    # brew install glances
    # brew install xh
    # brew install zoxide
    # brew install gtop
    # brew install jq
}

essential_install() {
    essential_ubuntu_install
    essential_mac_install

    docker_install

    brew_packages_install
}

essential_mac_check() {
    is_mac || return 1

    cmd_check brew trash 7z greadlink trash
}

essential_ubuntu_check() {
    is_ubuntu || return 1

    cmd_check p7zip dconf xsel xclip trash-put gcc
    is_gui && cmd_check google-chrome firefox
}

essential_check() {
    cmd_check curl wget git tree ag rg fasd fzf gh gpg tmux unar zip gawk urlview
    cmd_check docker
    cmd_check lsd duf delta broot fd btm procs
    if is_ubuntu; then
        cmd_check batcat
    else
        cmd_check bat
    fi
    essential_mac_check
    essential_ubuntu_check
}
