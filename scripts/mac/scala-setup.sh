DOTFILES="$(dirname "$0"/../..)"

source $DOTFILES/scripts/mac/lib/base.sh
source $DOTFILES/scripts/mac/lib/essential.sh

emacs&

source $DOTFILES/scripts/mac/lib/java.sh
source $DOTFILES/scripts/mac/lib/scala.sh

sbt console
chsh -s /bin/zsh
