source_one() {
  if file_exists "$CURRENT_DIR/scripts/mods/${1}.sh"; then
    slog "Sourcing $CURRENT_DIR/scripts/mods/${1}.sh"
    source "$CURRENT_DIR/scripts/mods/$1.sh"
  fi
}

mods_source() {
  while [[ $# -gt 0 ]]; do
    slog "Sourcing $1"
    source_one "$1"
    shift
  done
}

mods_setup() {
  while [[ $# -gt 0 ]]; do
    slog "Setting up $1"
    fn_exists "${1}_setup" && "${1}_setup"
    shift
  done
}

mods_check() {
  while [[ $# -gt 0 ]]; do
    slog "Checking $1"
    fn_exists "${1}_check" && "${1}_check"
    shift
  done
}

install_one() {
  if fn_exists "${1}_install"; then
    slog "Installing $1"
    "${1}_install"
  fi
}

mods_install() {
  while [[ $# -gt 0 ]]; do
    install_one "$1"
    shift
  done
}

mods_cleanup() {
  while [[ $# -gt 0 ]]; do
    slog "Cleaning up $1"
    fn_exists "${1}_cleanup" && "${1}_cleanup"
    shift
  done
}
