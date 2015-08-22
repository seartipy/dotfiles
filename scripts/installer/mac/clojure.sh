brew install leiningen
mkdir ~/.lein > /dev/null
sln $SEARTIPY_HOME/dotfiles/common/profiles.clj ~/.lein/profiles.clj
~/bin/lein > /dev/null
