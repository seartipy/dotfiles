source $DOTFILES/scripts/linux/lib/base.sh

source $DOTFILES/scripts/linux/lib/java-packages.sh
source $DOTFILES/scripts/linux/lib/scala-packages.sh

source$DOTFILES/scripts/linux/ lib/java-install.sh
source $DOTFILES/scripts/linux/lib/scala-install.sh

sbt console

chsh -s /bin/zsh
