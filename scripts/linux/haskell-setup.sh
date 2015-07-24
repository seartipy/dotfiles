DOTFILES="$(dirname "$0")"

source $DOTFILES/lib/base.sh

source $DOTFILES/lib/haskell-packages.sh
source $DOTFILES/lib/haskell-install.sh

chsh -s /bin/zsh
