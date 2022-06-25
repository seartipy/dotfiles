#! /usr/bin/env bash

# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${CURRENT_DIR}/scripts/utils.sh"

main() {
    sln "$CURRENT_DIR"/gitconfig ~/.gitconfig

    if is_linux; then
        sln "$CURRENT_DIR"/vscode/keybindings.json ~/.config/Code/User/keybindings.json
        sln "$CURRENT_DIR"/vscode/settings.json ~/.config/Code/User/settings.json
    elif is_mac; then
        sln "$CURRENT_DIR"/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
        sln "$CURRENT_DIR"/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"
    fi
}

main
