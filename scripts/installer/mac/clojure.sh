brew install leiningen
mkdir ~/.lein 2>& /dev/null
sln $SEARTIPY_HOME/dotfiles/common/profiles.clj ~/.lein/profiles.clj
~/bin/lein > /dev/null
