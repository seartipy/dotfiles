curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
chmod +x ~/bin/lein
mkdir ~/.lein
ln -s $SEARTIPY_HOME/dotfiles/common/profiles.clj ~/.lein/profiles.clj
~/bin/Lein
