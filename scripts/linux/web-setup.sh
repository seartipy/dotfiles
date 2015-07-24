DOTFILES="$(dirname "$0")"

source $DOTFILES/lib/base.sh

source $DOTFILES/lib/web-packages.sh
source $DOTFILES/lib/web-install.sh

chsh -s /bin/zsh
