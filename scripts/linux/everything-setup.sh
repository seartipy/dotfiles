DOTFILES="$(dirname "$0"/../..)"

source $DOTFILES/base.sh

emacs&

source $DOTFILES/java-packages.sh
source $DOTFILES/clojure-packages.sh
source $DOTFILES/scala-packages.sh
source $DOTFILES/python-packages.sh
source $DOTFILES/web-packages.sh
source $DOTFILES/cpp-packages.sh
source $DOTFILES/haskell-packages.sh
source $DOTFILES/additional-packages.sh
source $DOTFILES/ruby-packages.sh

source $DOTFILES/java-install.sh
source $DOTFILES/clojure-install.sh
source $DOTFILES/scala-install.sh
source $DOTFILES/python-install.sh
source $DOTFILES/web-install.sh
source $DOTFILES/cpp-install.sh
source $DOTFILES/haskell-install.sh
source $DOTFILES/additional-install.sh
source $DOTFILES/ruby-install.sh

lein repl
sbt console

chsh -s /bin/zsh
