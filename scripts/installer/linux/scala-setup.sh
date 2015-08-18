source $DOTFILES/linux/lib/base.sh

source $DOTFILES/linux/lib/java-packages.sh
source $DOTFILES/linux/lib/scala-packages.sh

source$DOTFILES/linux/ lib/java-install.sh
source $DOTFILES/linux/lib/scala-install.sh

sbt console

chsh -s /bin/zsh
