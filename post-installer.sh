#! /usr/bin/env bash

# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

has_cmd() {
    command -v "$1" > /dev/null
}

smd() {
    [ -d "$1" ] && return 1

    echo "INFO: Creating directory $1"
    mkdir -p "$1" 2> /dev/null
}

srm() {
    for f in "$@"; do
        if [ -L "$f" ]; then
            rm -f "$f" && echo "INFO: Removing existing line $f"
        elif has_cmd trash-put; then
            trash-put "$f" 2> /dev/null && echo "INFO: Trashed $f"
        elif has_cmd trash; then
            trash "$f" 2> /dev/null && echo "INFO: Trashed $f"
        else
            echo "ERROR: trash not installed, cannot rm"
        fi
    done
}

fln() {
    if [ -e "$1" ]; then
        srm "$2"
    else
        echo "ERROR: $1 does not exist, cannot create link $2"
        return 1
    fi
    echo "INFO: Creating link $2 to $1"
    ln -s "$1" "$2"
}

is_linux() {
    [ "$OSTYPE" == "linux-gnu" ]
}

is_mac() {
    [[ "$OSTYPE" == "darwin"* ]]
}

citrix_fix() {
    [[ -d "/opt/Citrix/ICAClient/keystore/cacerts" ]] && sudo ln -s /usr/share/ca-certificates/mozilla/* /opt/Citrix/ICAClient/keystore/cacerts
}

main() {
    fln "$CURRENT_DIR"/gitconfig ~/.gitconfig

    if is_linux; then
        fln "$CURRENT_DIR"/vscode/keybindings.json ~/.config/Code/User/keybindings.json
        fln "$CURRENT_DIR"/vscode/settings.json ~/.config/Code/User/settings.json
    elif is_mac; then
        fln "$CURRENT_DIR"/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
        fln "$CURRENT_DIR"/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
    fi

    citrix_fix
}

main
