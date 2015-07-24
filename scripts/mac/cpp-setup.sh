DOTFILES="$(dirname "$0"/../..)"

source $DOTFILES/scripts/mac/lib/base.sh
source $DOTFILES/scripts/mac/lib/essential.sh

emacs&

source $DOTFILES/scripts/mac/lib/cpp.sh

chsh -s /bin/zsh
