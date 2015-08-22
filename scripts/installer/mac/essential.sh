# homebrew and caskroom

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

# taps

brew tap caskroom/versions

# upgrade all packages

brew update && brew upgrade

brew install wget tree tmux fasd  ctags gibo gpg unrar p7zip trash coreutils
