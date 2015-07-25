echo "Enter password for changing your shell to zsh:"
chsh -s /bin/zsh

#### source code pro fonts

wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
unzip 1.030R-it.zip
mkdir ~/.fonts
cp source-code-pro*/OTF/*.otf ~/.fonts
fc-cache -f -v
rm -f 1.030R-it.zip
rm -rf source-code-pro*

echo "Installation done! Launching applications, these might fail, ignore them"

emacs&
lein repl
sbt console

# vim

curl http://j.mp/spf13-vim3 -L -o - | sh
osascript -e 'tell application "Finder" to make alias file to POSIX file "/usr/local/Cellar/macvim/7.4-76/MacVim.app" at POSIX file "/Applications"'

echo "Everything done! Reboot your system!"
