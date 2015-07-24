DOTFILES="$(dirname "$0"/../..)"

source $DOTFILES/scripts/linux/lib/base.sh

emacs&

source $DOTFILES/scripts/linux/lib/java-packages.sh
source $DOTFILES/scripts/linux/lib/clojure-packages.sh
source $DOTFILES/scripts/linux/lib/scala-packages.sh
source $DOTFILES/scripts/linux/lib/python-packages.sh
source $DOTFILES/scripts/linux/lib/web-packages.sh
source $DOTFILES/scripts/linux/lib/cpp-packages.sh
source $DOTFILES/scripts/linux/lib/haskell-packages.sh
source $DOTFILES/scripts/linux/lib/additional-packages.sh
source $DOTFILES/scripts/linux/lib/ruby-packages.sh

source $DOTFILES/scripts/linux/lib/java-install.sh
source $DOTFILES/scripts/linux/lib/clojure-install.sh
source $DOTFILES/scripts/linux/lib/scala-install.sh
source $DOTFILES/scripts/linux/lib/python-install.sh
source $DOTFILES/scripts/linux/lib/web-install.sh
source $DOTFILES/scripts/linux/lib/cpp-install.sh
source $DOTFILES/scripts/linux/lib/haskell-install.sh
source $DOTFILES/scripts/linux/lib/additional-install.sh
source $DOTFILES/scripts/linux/lib/ruby-install.sh

lein repl
sbt console

chsh -s /bin/zsh
