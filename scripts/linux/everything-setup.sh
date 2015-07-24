DOTFILES="$(dirname "$0")"

source $DOTFILES/lib/base.sh

emacs&

source $DOTFILES/lib/java-packages.sh
source $DOTFILES/lib/clojure-packages.sh
source $DOTFILES/lib/scala-packages.sh
source $DOTFILES/lib/python-packages.sh
source $DOTFILES/lib/web-packages.sh
source $DOTFILES/lib/cpp-packages.sh
source $DOTFILES/lib/haskell-packages.sh
source $DOTFILES/lib/additional-packages.sh
source $DOTFILES/lib/ruby-packages.sh

source $DOTFILES/lib/java-install.sh
source $DOTFILES/lib/clojure-install.sh
source $DOTFILES/lib/scala-install.sh
source $DOTFILES/lib/python-install.sh
source $DOTFILES/lib/web-install.sh
source $DOTFILES/lib/cpp-install.sh
source $DOTFILES/lib/haskell-install.sh
source $DOTFILES/lib/additional-install.sh
source $DOTFILES/lib/ruby-install.sh

# lein repl
# sbt console

chsh -s /bin/zsh
