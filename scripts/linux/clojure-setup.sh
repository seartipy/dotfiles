source $DOTFILES/scripts/linux/lib/base.sh

source $DOTFILES/scripts/linux/lib/java-packages.sh
source $DOTFILES/scripts/linux/lib/clojure-packages.sh

source $DOTFILES/scripts/linux/lib/java-install.sh
source $DOTFILES/scripts/linux/lib/clojure-install.sh

lein repl

chsh -s /bin/zsh
