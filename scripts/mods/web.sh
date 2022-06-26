#! /usr/bin/env bash

# web

web_check() {
    cmd_check nvm
    cmd_check npm

    has_cmd npm || return 1

    cmd_check yarn pnpm bash-language-server ncu

    if is_ubuntu; then
        if ! grep "fs.inotify.max_user_watches" /etc/sysctl.conf > /dev/null; then
            warn "max user watches not set properly in /etc/sysctl.conf"
        fi
    fi
}

nvm_install() {
    [ -s ~/.nvm/nvm.sh ] && source ~/.nvm/nvm.sh

    slog "Installing nvm"
    if ! has_cmd nvm; then
        smd ~/.nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        source ~/.nvm/nvm.sh
    fi
    has_cmd nvm || return 1

    nvm install node
    nvm alias default node
}

web_install() {
    nvm_install

    slog "Installing npm packages for web development"
    npi yarn pnpm bash-language-server npm-check-updates

    if is_ubuntu && ! grep "fs.inotify.max_user_watches" /etc/sysctl.conf > /dev/null; then
        echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf > /dev/null && sudo sysctl -p
    fi
}

# volta_install() {
#     has_cmd volta || return 1
#     curl https://get.volta.sh | bash
#     volta install node
# }
