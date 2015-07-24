DOTFILES="$(dirname "$0")"

source $DOTFILES/lib/base.sh

source $DOTFILES/lib/java-packages.sh
source $DOTFILES/lib/scala-packages.sh

source$DOTFILES/ lib/java-install.sh
source $DOTFILES/lib/scala-install.sh

sbt console

chsh -s /bin/zsh
