source $DOTFILES/mac/lib/base.sh
source $DOTFILES/mac/lib/essential.sh

emacs&

source $DOTFILES/mac/lib/java.sh
source $DOTFILES/mac/lib/clojure.sh

lein repl
chsh -s /bin/zsh
