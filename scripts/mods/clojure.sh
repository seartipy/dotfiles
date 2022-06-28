
linux_lein_install() {
    is_linux || return 1
    has_cmd ~/bin/lein && return 1

    slog "Installing leiningen"
    curl -L https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
    chmod +x ~/bin/lein
}

clojure_setup() {
    fn_exists jdk_install || source_one java
}

clojure_mac_install() {
    is_mac || return 1

    slog "Installing leiningen"
    brew install leiningen
}

clojure_install() {
    jdk_install

    clojure_mac_install
    linux_lein_install
}

clojure_check() {
    cmd_check lein
}
