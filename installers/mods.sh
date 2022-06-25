CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${CURRENT_DIR}/scripts/utils.sh"
source "${CURRENT_DIR}/installers/installer_utils.sh"

source_one() {

  if file_exists "$CURRENT_DIR/installers/mods/$1.sh"; then
    slog "Sourcing $CURRENT_DIR/installers/mods/$1.sh"
    source "$CURRENT_DIR/installers/mods/$1.sh"
  fi
}

mods_source() {
  while [[ $# -gt 0 ]]; do
    source_one "$1"
    shift
  done
}

mods_setup() {
  while [[ $# -gt 0 ]]; do
    has_cmd "$1_setup" && "$1_setup"
    shift
  done
}

mods_check() {
  while [[ $# -gt 0 ]]; do
    has_cmd "$1_check" && "$1_check"
    shift
  done
}

install_one() {
  if has_cmd "$1_install"; then
    "$1_install"
  else
    warn "installer not available for: $1"
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
    has_cmd "$1_cleanup" && "$1_cleanup"
    shift
  done
}
