sudo add-apt-repository ppa:zeal-developers/ppa -y # zeal

# google chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

# virtualbox
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian vivid contrib" >> /etc/apt/sources.list'

sudo add-apt-repository ppa:eugenesan/ppa -y # smartgit
sudo add-apt-repository  ppa:nilarimogard/webupd8 -y # youtube-dl etc
sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y # sublime text 3 editor
sudo add-apt-repository  ppa:webupd8team/atom -y # atom editor

# scala
echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823

# haskell
sudo add-apt-repository ppa:hvr/ghc -y

# java
echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo add-apt-repository  ppa:webupd8team/java -y
