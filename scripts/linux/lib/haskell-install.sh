# should it be cabal-1.22 ?
cabal-1.22 update
cabal-1.22 install alex happy hlint  hoogle structured-haskell-mode stylish-haskell hasktags hindent hdevtools

git clone https://github.com/kazu-yamamoto/ghc-mod.git ~/ghc-mod
cabal-1.22 install ~/ghc-mod
