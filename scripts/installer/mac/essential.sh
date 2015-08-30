# homebrew
if [ ! $(which brew) ]; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

#caskroom
if [ ! $(which brew cask) ]; then
    brew install caskroom/cask/brew-cask
fi
brew tap caskroom/versions

brew update && brew upgrade

brew install wget
brew install tree
brew install tmux
brew install fasd
brew install ctags
brew install gibo
brew install gpg
brew install unrar
brew install p7zip
brew install trash
brew install coreutils
