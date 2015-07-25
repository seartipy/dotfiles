#!/bin/bash

# INSTALLER_SCRIPT_OPTIONS=(
#     'everything',
#     'essential',
#     'clojure',
#     'scala',
#     'cpp',
#     'python',
#     'web',
#     'haskell',
#     'ruby'
# )

if [ $# -ge 1 ]
then
    INSTALLER_SCRIPT=`echo $1 |  tr '[:upper:]' '[:lower:]' | xargs`
else
    INSTALLER_SCRIPT="everything"
fi

echo "Install xcode command line tools..."
clang++ -v

echo "Clone dotfiles..."
git clone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles

echo "Start install script..."

DOTFILES="$HOME/$(dirname "$0")"

if [ "$(uname)" == "Darwin" ]
then
    source "$HOME/dotfiles/scripts/mac/${INSTALLER_SCRIPT}-setup.sh"
else
    source "$HOME/dotfiles/scripts/linux/${INSTALLER_SCRIPT}-setup.sh"
fi
