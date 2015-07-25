source $DOTFILES/linux/lib/base.sh

source $DOTFILES/linux/lib/java-packages.sh
source $DOTFILES/linux/lib/clojure-packages.sh

source $DOTFILES/linux/lib/java-install.sh
source $DOTFILES/linux/lib/clojure-install.sh

lein repl

chsh -s /bin/zsh
