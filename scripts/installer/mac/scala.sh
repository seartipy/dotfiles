brew install sbt
brew install scala
smkdir ~/.sbt/0.13/plugins
sln $SEARTIPY_HOME/dotfiles/common/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt
sbt -batch > /dev/null
