scala_setup() {
    fn_exists jdk_install || source_one java
}

scala_install() {
    has_cmd coursier && return 1
    jdk_install

    slog "Install scala"
    if is_linux; then
        curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz | gzip -d > cs && chmod +x cs
        ./cs setup
    elif is_mac; then
        brew install coursier/formulas/coursier && cs setup
    fi
    srm cs
    path_export "$HOME/.local/share/coursier/bin"
}

scala_check() {
    cmd_check sbt scala amm coursier
}
