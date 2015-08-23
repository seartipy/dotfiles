if ! ls /etc/apt/sources.list.d | grep sbt > /dev/null; then
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
    echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
    sudo apt-get update
fi
sudo apt-get -y install sbt

smkdir~/.sbt/0.13/plugins
sln $SEARTIPY_HOME/dotfiles/common/plugins.sbt ~/.sbt/0.13/plugins/plugins.sbt
sbt -batch > /dev/null
