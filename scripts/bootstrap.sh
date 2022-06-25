#! /usr/bin/env bash

{

curdir=$(pwd)

rm -f ~/.seartipy-installer.log ~/.seartipy-error.log ~/.seartipy-output.log 2> /dev/null

keep_sudo_running

create_dirs

# check if this script is run in interactive mode for testing
if [[ $- = *i* ]]; then
    slog "Running pre installer check..."
    slog "if this does not succeed you must first at least install essentials by running this script without parameters"
    pre_installer_check
    slog "installer check succeeded, you could run functions in this script for testing"
else
    installer "$@" > >(tee ~/.seartipy-output.log) 2> >(tee ~/.seartipy-error.log >&2)
fi

cd "$curdir"

}
