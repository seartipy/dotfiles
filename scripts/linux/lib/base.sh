source $DOTFILES/scripts/linux/lib/all-ppas.sh
sudo apt-get update && sudo apt-get upgrade -y

source $DOTFILES/scripts/linux/lib/essential-packages.sh
source $DOTFILES/scripts/linux/lib/essential-install.sh
