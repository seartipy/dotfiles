brew install sbt scala
mkdir -p ~/.sbt/0.13/plugins > /dev/null
sln $SEARTIPY_HOME/dotfiles/common/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt
sbt -batch > /dev/null
