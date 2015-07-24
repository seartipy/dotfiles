DOTFILES="$(dirname "$0")"

source $DOTFILES/lib/base.sh
source $DOTFILES/lib/essential.sh

emacs&

source $DOTFILES/lib/java.sh
source $DOTFILES/lib/scala.sh

sbt console
chsh -s /bin/zsh
