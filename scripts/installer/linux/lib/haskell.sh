sudo add-apt-repository ppa:hvr/ghc -y
sudo apt-get update

sudo apt-get install -y ghc-7.10.2 cabal-install-1.22

cabal-1.22 update
cabal-1.22 install alex happy hlint hoogle structured-haskell-mode stylish-haskell hasktags hindent hdevtools ghc-mod