source $DOTFILES/linux/lib/base.sh

source $DOTFILES/linux/lib/java-packages.sh
source $DOTFILES/linux/lib/clojure-packages.sh
source $DOTFILES/linux/lib/scala-packages.sh
source $DOTFILES/linux/lib/python-packages.sh
source $DOTFILES/linux/lib/web-packages.sh
source $DOTFILES/linux/lib/cpp-packages.sh
source $DOTFILES/linux/lib/haskell-packages.sh
source $DOTFILES/linux/lib/additional-packages.sh
source $DOTFILES/linux/lib/ruby-packages.sh

source $DOTFILES/linux/lib/java-install.sh
source $DOTFILES/linux/lib/clojure-install.sh
source $DOTFILES/linux/lib/scala-install.sh
source $DOTFILES/linux/lib/python-install.sh
source $DOTFILES/linux/lib/web-install.sh
source $DOTFILES/linux/lib/cpp-install.sh
source $DOTFILES/linux/lib/haskell-install.sh
source $DOTFILES/linux/lib/additional-install.sh
source $DOTFILES/linux/lib/ruby-install.sh

# lein repl
# sbt console

chsh -s /bin/zsh
