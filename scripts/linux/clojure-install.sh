echo "=================Updating ubuntu...================="

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update && sudo apt-get upgrade -y

echo "===============Installing packages...==============="

sudo apt-get install -y build-essential emacs24 curl tree tmux git xsel xclip silversearcher-ag exuberant-ctags editorconfig zsh kdiff3 oracle-java8-installer chromium-browser
sudo apt-get autoremove && sudo apt-get clean && sudo apt-get autoclean

echo "===============Installing dotfiles...==============="

git clone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles
git clone https://github.com/pervezfunctor/emacs.d.git ~/housem.d
ln -s ~/dotfiles/common/tmux.conf ~/.tmux.conf
cp ~/dotfiles/common/gitconfig ~/.gitconfig

echo "=======Installing Adobe Source Code Pro fonts======"

wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
unzip 1.030R-it.zip
mkdir ~/.fonts
cp 1.030R-it.zip/OTF/*.otf ~/.fonts
fc-cache -f -v
rm -f 1.030R-it.zip

echo "================Installing emacs...================"

git clone --recursive https://github.com/syl20bnr/spacemacs ~/spacemacs
ln -s ~/spacemacs/ ~/.emacs.d
ln -s ~/dotfiles/common/spacemacs ~/.spacemacs

echo "Opening emacs, Press Ctrl+X Ctrl+C to exit emacs after installation"

emacs&

echo "=================Installing zsh...=================="

git clone https://github.com/zsh-users/antigen.git ~/antigen
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup
ln -s ~/dotfiles/common/zshrc ~/.zshrc

echo "===============Installing clojure...==============="

mkdir ~/bin
curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
chmod +x ~/bin/lein
mkdir ~/.lein
ln -s ~/dotfiles/common/profiles.clj ~/.lein/profiles.clj

echo "===============Installing CLI apps...==============="

curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so ~/bin/gibo && chmod +x ~/bin/gibo && ~/bin/gibo -u
git clone https://github.com/clvv/fasd.git ~/fasd
cd ~/fasd && PREFIX=$HOME make install && cd
chsh -s /bin/zsh

echo "======Starting clojure repl(use Ctrl+D to exit)===="

~/bin/lein repl

echo "=======Installation done. Reboot your system======="

