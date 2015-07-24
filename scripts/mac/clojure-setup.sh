DOTFILES="$(dirname "$0"/../..)"

source $DOTFILES/scripts/mac/lib/base.sh
source $DOTFILES/scripts/mac/lib/essential.sh

emacs&

source $DOTFILES/scripts/mac/lib/java.sh
source $DOTFILES/scripts/mac/lib/clojure.sh

lein repl
chsh -s /bin/zsh
