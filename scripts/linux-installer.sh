echo "Install git..."
sudo apt-get install git

echo "Clone dotfiles..."
git clone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles

echo "Start install script..."
bash ~/dotfiles/scripts/mac/everything-setup.sh
