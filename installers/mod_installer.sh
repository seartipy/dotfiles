CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${CURRENT_DIR}/scripts/utils.sh"
source "${CURRENT_DIR}/installers/installer_utils.sh"

source_one() {
  slog "Sourcing $CURRENT_DIR/installers/mods/$1.sh"

  if file_exists "$CURRENT_DIR/installers/mods/$1.sh"; then
    source "$CURRENT_DIR/installers/mods/$1.sh"
  else
    warn "Unknown installer option: $1"
  fi
}

mod_source() {
  while [[ $# -gt 0 ]]; do
    source_one "$1"
    shift
  done
}

mod_setup() {
  while [[ $# -gt 0 ]]; do
    has_cmd "$1_setup" && "$1_setup"
    shift
  done
}

mod_check() {
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

mod_install() {
  while [[ $# -gt 0 ]]; do
    install_one "$1"
    shift
  done
}

mod_cleanup() {
  while [[ $# -gt 0 ]]; do
    has_cmd "$1_cleanup" && "$1_cleanup"
    shift
  done
}

mod_installer() {
  slog "Installing $*"
  mod_source $*
  mod_setup $*
  mod_install $*
  mod_check $*
  mod_cleanup $*
}

mod_installer $*
