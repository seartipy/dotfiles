echo "Install xcode command line tools..."
clang++ -v

echo "Clone dotfiles..."
git clone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles

echo "Start install script..."
source ~/dotfiles/scripts/mac/everything-setup.sh
