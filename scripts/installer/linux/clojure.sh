if lein -v > /dev/null; then
    lein upgrade
else
    curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > ~/bin/lein
    chmod +x ~/bin/lein
fi

smkdir ~/.lein
sln $SEARTIPY_HOME/dotfiles/common/profiles.clj ~/.lein/profiles.clj
lein > /dev/null
