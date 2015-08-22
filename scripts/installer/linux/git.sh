if ! ls /etc/apt/sources.list.d | grep eugenesan-ubuntu-ppa > /dev/null; then
    sudo add-apt-repository ppa:eugenesan/ppa -y # smartgit
    sudo apt-get update
fi
sudo apt-get install -y smartgit

sudo apt-get install -y kdiff3
sudo apt-get install -y git-extras
sudo apt-get install -y meld
