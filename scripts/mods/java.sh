#! /usr/bin/env bash

jdk_mac_install() {
    is_mac || return 1

    slog "Installing java"
    # java
    brew install java
}

jdk_ubuntu_install() {
    is_ubuntu || return 1
    is_ubuntu && ubuntu_update

    slog "Installing Java"
    if is_ubuntu; then
    sudo apt-get install -y openjdk-18-jdk
    sudo apt-get install -y openjdk-18-source
    sudo apt-get install -y visualvm

    sudo apt-get install -y default-jdk
    sudo apt-get install -y default-jdk-doc
    fi
}

jdk_install() {
    has_cmd javac

    jdk_mac_install
    jdk_ubuntu_install
}

# sdkman_install() {
#     has_cmd sdk && return 0
#     curl -s "https://get.sdkman.io" | bash
# }


java_install() {
    jdk_install
    # sdkman_install
    # source "$HOME/.sdkman/bin/sdkman-init.sh"
    # has_cmd maven || sdk install maven < /dev/null
    # has_cmd gradle || sdk install gradle < /dev/null
    # has_cmd groovy || sdk install groovy < /dev/null
}

java_check() {
    # source "$HOME/.sdkman/bin/sdkman-init.sh"
    has_cmd javac java # sdk groovy maven gradle
}
