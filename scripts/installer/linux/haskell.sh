if ! ls /etc/apt/sources.list.d | grep hvr-ubuntu-ghc > /dev/null; then
    sudo add-apt-repository ppa:hvr/ghc -y
    sudo apt-get update
fi
sudo apt-get install -y ghc-7.10.2 cabal-install-1.22

cabal update
cabal install alex
cabal install happy
cabal install hlint
cabal install hoogle
cabal install structured-haskell-mode
cabal install stylish-haskell
cabal install hasktags
cabal install hindent
cabal install hdevtools
cabal install ghc-mod
