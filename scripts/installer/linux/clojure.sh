if lein -v > /dev/null; then
    lein upgrade
else
    curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
    chmod +x ~/bin/lein
fi

mkdir ~/.lein 2> /dev/null
sln $SEARTIPY_HOME/dotfiles/common/profiles.clj ~/.lein/profiles.clj
~/bin/lein > /dev/null
