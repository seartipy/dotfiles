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


linux_lein_install() {
    is_linux || return 1
    has_cmd ~/bin/lein && return 1

    slog "Installing leiningen"
    curl -L https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
    chmod +x ~/bin/lein
}

clojure_mac_install() {
    is_mac || return 1

    slog "Installing clojure packages"
    brew install leiningen
}

clojure_install() {
    jdk_install

    clojure_mac_install
    linux_lein_install
}


scala_install() {
    has_cmd coursier && return 1
    jdk_install

    slog "Install scala"
    curl -Lo cs https://git.io/coursier-cli-linux && chmod +x cs && ./cs setup --yes
}


java_check() {
    # source "$HOME/.sdkman/bin/sdkman-init.sh"
    has_cmd javac java # sdk groovy maven gradle
}

scala_check() {
    cmd_check javac sbt scala amm coursier
}

clojure_check() {
    cmd_check javac lein
}


install_all() {
    [ -n "$JAVA" ] && java_install
    [ -n "$CLOJURE" ] && clojure_install
    [ -n "$SCALA" ] && scala_install
}

post_installer_check() {
    [ -n "$JAVA" ] && dotfiles_check
    [ -n "$CLOJURE" ] && clojure_check
    [ -n "$SCALA" ] && scala_check
}
