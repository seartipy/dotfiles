DOTFILES="$(dirname "$0")"

source $DOTFILES/lib/base.sh
source $DOTFILES/lib/essential.sh

emacs&

source $DOTFILES/lib/web.sh

chsh -s /bin/zsh
