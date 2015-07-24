DOTFILES="$(dirname "$0"/../..)"

source $DOTFILES/scripts/mac/lib/base.sh
source $DOTFILES/scripts/mac/lib/essential.sh

emacs&

source $DOTFILES/scripts/mac/lib/java.sh
source $DOTFILES/scripts/mac/lib/clojure.sh
source $DOTFILES/scripts/mac/lib/scala.sh
source $DOTFILES/scripts/mac/lib/python.sh
source $DOTFILES/scripts/mac/lib/web.sh
source $DOTFILES/scripts/mac/lib/cpp.sh
source $DOTFILES/scripts/mac/lib/haskell.sh
source $DOTFILES/scripts/mac/lib/ruby.sh
source $DOTFILES/scripts/mac/lib/additional.sh

lein repl
sbt console

chsh -s /bin/zsh
