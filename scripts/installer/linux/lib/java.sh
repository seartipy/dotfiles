# java

if ! ls /etc/apt/sources.list.d | grep webupd8team-ubuntu-java; then

    echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
    sudo add-apt-repository  ppa:webupd8team/java -y
    sudo apt-get update
fi
sudo apt-get install -y oracle-java8-installer
