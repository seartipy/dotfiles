source $DOTFILES/lib/base.sh

source $DOTFILES/lib/java-packages.sh
source $DOTFILES/lib/clojure-packages.sh

source $DOTFILES/lib/java-install.sh
source $DOTFILES/lib/clojure-install.sh

lein repl

chsh -s /bin/zsh
