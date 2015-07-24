DOTFILES="$(dirname "$0")"

source $DOTFILES/lib/base.sh
source $DOTFILES/scripts/mac/lib/essential.sh

emacs&

source $DOTFILES/lib/java.sh
source $DOTFILES/lib/clojure.sh
source $DOTFILES/lib/scala.sh
source $DOTFILES/lib/python.sh
source $DOTFILES/lib/web.sh
source $DOTFILES/lib/cpp.sh
source $DOTFILES/lib/haskell.sh
source $DOTFILES/lib/ruby.sh
source $DOTFILES/lib/additional.sh

lein repl
sbt console

chsh -s /bin/zsh
