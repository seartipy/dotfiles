# utils

BOLD=$(tput bold)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)
# WHITE=$(tput setaf 7)

slog() {
    echo "
${BOLD}${GREEN}SEARTIPY: ${RESET} $1
"
}

warn() {
    echo "
${BOLD}${YELLOW}WARNING: ${RESET} $1
"
}

err_exit() {
    echo "
${BOLD}${RED}FATAL: ${RESET} $1
"
    exit 1
}

is_ubuntu() {
    has_cmd lsb_release || return 1
    local OS
    OS=$(lsb_release -i | cut -d ':' -f2)
    [[ "$OS" == *"Ubuntu" ]] || [[ "$OS" == *"neon" ]] || [[ "$OS" == *"elementary" ]] || [[ "$OS" == *"LinuxMint" ]] || [[ "$OS" == *"Pop" ]]
}

is_fedora() {
    is_mac && return 1

    cat /etc/os-release | grep "^ID=fedora$" > /dev/null
}

is_linux() {
    [[ "$OSTYPE" == "linux-gnu" ]]
}

is_mac() {
    [[ "$OSTYPE" == "darwin"* ]]
}

is_wsl() {
    is_ubuntu && grep -qi microsoft /proc/version > /dev/null
}

fn_exists() {
    [[ $(type -t $1) == function ]]
}

has_cmd() {
    command -v "$1" > /dev/null
}

smv() {
    if mv "$1" "$2" 2> /dev/null; then
        slog "Moved $1 to $2"
    fi
}

smd() {
    [ -d "$1" ] && return 1
    slog "Creating directory $1"
    mkdir -p "$1" 2> /dev/null
}

srm() {
    for f in "$@"; do
        if [ -L "$f" ]; then
            rm -f "$f" && slog "Removing existing link $f"
        elif has_cmd trash-put; then
            trash-put "$f" 2> /dev/null && slog "Trashed $f"
        elif has_cmd trash; then
            trash "$f" 2> /dev/null && slog "Trashed $f"
        else
            warn "trash not installed, cannot rm $f"
        fi
    done
}

fln() {
    if [ -e "$1" ]; then
        srm "$2"
    else
        warn "$1 does not exist, cannot create link $2"
        return 1
    fi
    slog "Creating link $2 to $1"
    ln -s "$1" "$2"
}

sln() {
    if ! [ -e "$1" ]; then
        warn "$1 does not exist, cannot create the link $2"
        return 1
    elif [ -L "$2" ]; then
        srm "$2"
    elif [ -e "$2" ]; then
        warn "$2 exists and not a symbolic link! not creating link"
        return 1
    fi
    slog "Creating link $2 to $1"
    ln -s "$1" "$2"
}

sclone() {
    local dest=${*: -1}
    local src=${*: -2:1}

    if [ -d "$dest" ]; then
        if cd "$dest"; then
            slog "Pulling $dest"
            if has_cmd git-up; then
                git-up
            else
                git pull --ff-only
            fi
            cd
        fi
    else
        slog "Cloning $src to $dest"
        git clone "$@"
    fi
}

mclone() {
    sclone "$@" --depth=1
}

fclone() {
    local dest=${*: -1}
    local src=${*: -2:1}

    srm "$dest"
    slog "Cloning $src to $dest"
    git clone "$@"
}

scopy() {
    if [ -e "$2" ] || [ -L "$2" ]; then
        return 0
    else
        slog "Copying $1 to $2"
        cp "$1" "$2"
    fi
}

fcopy() {
    if [ -e "$2" ] || [ -L "$2" ]; then
        srm "$2"
    fi
    slog "Copying $1 to $2"
    cp "$1" "$2"
}

pre_cmd_check() {
    for cmd in "$@"; do
        has_cmd "$cmd" || err_exit "$cmd not installed, quitting"
    done
}

pre_dir_check() {
    for dir in "$@"; do
        [ -d "$dir" ] || err_exit "$dir does not exist, quitting"
    done
}

cmd_check() {
    for cmd in "$@"; do
        has_cmd "$cmd" || warn "$cmd not installed"
    done
}

dir_exists() {
    [[ -d "$1" ]]
}

file_exists() {
     [[ -f "$1" ]]
}
dir_check() {
    for dir in "$@"; do
        dir_exists "$dir" || warn "$dir does not exist"
    done
}

ln_to_exists() {
    local rl=readlink
    is_mac && rl=greadlink
    [[ "$1" == $($rl -f "$2") ]]
}

ln_check() {
    ln_to_exists "$1" "$2" || warn "$2 not a link to $1"
}

file_check() {
    for f in "$@"; do
        [ -f "$f" ] || warn "$f does not exist"
    done
}

ppa_exists() {
    ls /etc/apt/sources.list.d | grep "$1" > /dev/null
}

ppa_check() {
    ppa_exists "$1" || warn "$1 ppa not added"
}

apm_exists() {
    apm ls --installed --bare | cut -d "@" -f 1 | grep "^$1$" > /dev/null
}

apm_check() {
    for p in "$@"; do
        apm_exists "$p" || warn "$p atom package not installed"
    done
}

npm_exists() {
    npm list --global --depth=0 "$1" 2> /dev/null | grep "$1" > /dev/null
}

npm_check() {
    for p in "$@"; do
        npm_exists "$p" || warn "$p npm package not installed"
    done
}

vsext_exists() {
    has_cmd code || return 1
    code --list-extensions | grep -i "$1" > /dev/null
}

vsext_check() {
    for p in "$@"; do
        vsext_exists "$p" || warn "$p vscode extension not installed"
    done
}

gem_exists() {
    gem list --local | grep "$1" > /dev/null
}

gem_check() {
    for p in "$@"; do
        gem_exists "$p" || warn "$p gem not installed"
    done
}

brew_exists() {
    brew list | grep "^$1$" > /dev/null
}

brew_check() {
    for p in "$@"; do
        brew_exists "$p" || warn "$p brew cask package not installed"
    done
}

brew_cask_exists() {
    brew cask list | grep "$1" > /dev/null
}

brew_cask_check() {
    for p in "$@"; do
        brew_cask_exists "$p" || warn "$p brew cask package not installed"
    done
}

apmi() {
    has_cmd apm || return 1

    for p in "$@"; do
        if ! apm_exists "$p"; then
            slog "Installing apm package $p"
            apm install "$p"
        fi
    done
}

apti() {
    for p in "$@"; do
        slog "Installing package $p"
        sudo apt-get install -y "$p"
    done
}

sysi() {
    for p in "$@"; do
        if is_mac; then
            brew install "$p"
        elif is_ubuntu; then
            sudo apt install -y "$p"
        fi
    done
}

stackexei() {
    has_cmd stack || return 1

    for p in "$@"; do
        stack install "$p"
    done
}

npi() {
    has_cmd npm || return 1

    for p in "$@"; do
        if ! npm_exists "$p"; then
            slog "Installing npm package $p"
            npm install -g "$p"
        fi
    done
}

gemi() {
    has_cmd gem || return 1

    for p in "$@"; do
        if ! gem_exists "$p"; then
            slog "Installing gem package $p"
            gem install "$p" --no-ri --no-rdoc
        fi
    done
}

path_export() {
    if [ -d $1 ]; then
        export PATH="$1:$PATH"
    else
        warn "can't export $1: not a directory"
    fi
}

ignore_path_export() {
    [ -d $1 ] && export PATH="$1:$PATH"
}

sexport() {
    if [ -d $2 ]; then
        export $1="$2"
    else
        warn "can't export $2: not a directory"
    fi
}

ignore_export() {
    [ -d $2 ] && export $1="$2"
}


keep_sudo_running() {
    # Ask for the administrator password upfront
    sudo -v

    # Keep-alive: update existing `sudo` time stamp until `.osx` has finished
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
}

setup_backup_dir() {
    BACKUP_DIR=~/.seartipy.backups

    if [ -d "$BACKUP_DIR" ]; then
        slog "moving $BACKUP_DIR to trash"
        srm $BACKUP_DIR
    fi

    smd $BACKUP_DIR

    if ! [ -d "$BACKUP_DIR" ]; then
        err_exit "cannot create $BACKUP_DIR, quitting"
    fi
}

pre_installer_check() {
    BACKUP_DIR=~/.seartipy.backups

    pre_cmd_check git curl wget unzip
    if is_ubuntu; then
        pre_cmd_check trash-put
    else
        pre_cmd_check trash
    fi
    pre_dir_check "$BACKUP_DIR" ~/bin
}
