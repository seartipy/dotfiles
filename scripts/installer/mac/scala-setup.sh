source $DOTFILES/mac/lib/base.sh
source $DOTFILES/mac/lib/essential.sh

emacs&

source $DOTFILES/mac/lib/java.sh
source $DOTFILES/mac/lib/scala.sh

sbt console
chsh -s /bin/zsh
