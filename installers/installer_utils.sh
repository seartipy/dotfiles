#! /usr/bin/env bash

{

is_gui() {
    [[ -n "$GUI" ]]
}

create_dirs() {
    setup_backup_dir
    smd ~/bin
}

path_setups() {
    export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
    is_ubuntu && export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

    [ -f ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

    is_mac && export PATH="$PATH:/usr/local/opt/go/libexec/bin"

    export PATH="$HOME/.cask/bin:$PATH"
}

pre_installer_check() {
    path_setups

    pre_cmd_check git curl wget unzip
    if is_ubuntu; then
        pre_cmd_check trash-put
    else
        pre_cmd_check trash
    fi
    pre_dir_check "$BACKUP_DIR" ~/bin
}

post_installer_setup() {
    path_setups
}

}
