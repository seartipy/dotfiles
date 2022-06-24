#! /usr/bin/env bash

{
curdir=$(pwd)

if is_ubuntu; then
    trash-put ~/seartipy-installer.log ~/seartipy-error.log ~/seartipy-output.log 2> /dev/null
else
    trash ~/seartipy-installer.log ~/seartipy-error.log ~/seartipy-output.log 2> /dev/null
fi

keep_sudo_running

create_dirs

if [[ $- = *i* ]]; then
    slog "Running pre installer check..."
    slog "if this does not succeed you must first at least install essentials by running this script without parameters"
    pre_installer_check
    slog "installer check succeeded, you could run functions in this script for testing"
else
    installer "$@" > >(tee ~/seartipy-output.log) 2> >(tee ~/seartipy-error.log >&2)
fi

cd "$curdir"

}
