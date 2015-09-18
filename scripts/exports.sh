if [[ "$OSTYPE" == "linux-gnu" ]]; then
    #java
    export JAVA_HOME="/usr/lib/jvm/java-8-oracle"
    export JDK_HOME="/usr/lib/jvm/java-8-oracle"

    #haskell
    export PATH="/opt/ghc/7.10.2/bin:$PATH"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    #java
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
    export JDK_HOME=`/usr/libexec/java_home -v 1.8`
fi

#ruby
export PATH="$HOME/.rvm/bin:$PATH"

#haskell
export PATH="$HOME/.cabal/bin:$PATH"

#emacs
export PATH="$HOME/.cask/bin:$PATH"

#node
export NVM_DIR="$HOME/.nvm"

#flow
export PATH="$PATH:$SEARTIPY_HOME/vendors/flow"

#python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/bin:$PATH"
