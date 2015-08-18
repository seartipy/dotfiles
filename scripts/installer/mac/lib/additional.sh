brew cask install atom google-chrome iterm2 dash android-file-transfer virtualbox transmission macdown github sublime-text3 vlc karabiner seil spectacle amethyst youtube-dl android-file-transfer github inkscape lightable paintbrush skype transmission xquartz

brew cask install betterzipql qlcolorcode qlimagesize qlmarkdown qlprettypatch qlstephen quicklook-csv quicklook-json suspicious-package webpquicklook

echo "Installation done! Launching applications, these might fail, ignore them"

lein repl
sbt console
emacs&

# vim

curl http://j.mp/spf13-vim3 -L -o - | sh
osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/Cellar/macvim/7.4-76/MacVim.app" at POSIX file "/Applications"'

echo "Everything done! Reboot your system!"
