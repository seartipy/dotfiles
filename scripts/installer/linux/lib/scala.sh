sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-get update

sudo apt-get -y install sbt

mkdir -p ~/.sbt/0.13/plugins
ln -s $SEARTIPY_HOME/dotfiles/common/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt
