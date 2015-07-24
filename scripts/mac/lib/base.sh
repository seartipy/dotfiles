# install xcode

clang++ -v

# homebrew and caskroom

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

# taps

brew tap railwaycat/emacsmacport
brew tap caskroom/versions

# upgrade all packages

brew update && brew upgrade
