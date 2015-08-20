# zeal
if ! ls /etc/apt/sources.list.d | grep zeal-developers-ubuntu; then
    sudo add-apt-repository ppa:zeal-developers/ppa -y # zeal
fi

# google chrome
if ! ls /etc/apt/sources.list.d | grep google.list; then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
fi

# virtualbox
if ! grep download.virtualbox.org/virtualbox/debian /etc/apt/sources.list; then
    wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
    sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian vivid contrib" >> /etc/apt/sources.list'
fi

# youtube-dl etc
if ! ls /etc/apt/sources.list.d | grep nilarimogard-ubuntu-webupd8; then
    sudo add-apt-repository  ppa:nilarimogard/webupd8 -y
fi

# sublime text 3 editor
if ! ls /etc/apt/sources.list.d | grep webupd8team-ubuntu-sublime-text-3; then
    sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
fi

# atom editor
if ! ls /etc/apt/sources.list.d | grep webupd8team-ubuntu-atom; then
    sudo add-apt-repository  ppa:webupd8team/atom -y
fi

sudo apt-get update

sudo apt-get install -y virtualbox-5.0 dkms
sudo apt-get install -y vlc
sudo apt-get install -y youtube-dl
sudo apt-get install -y sublime-text-installer
sudo apt-get install -y atom
sudo apt-get install -y zeal
sudo apt-get install -y google-chrome-stable

# source code pro fonts
wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
unzip 1.030R-it.zip
mkdir ~/.fonts
cp source-code-pro*/OTF/*.otf ~/.fonts
fc-cache -f -v
rm -f 1.030R-it.zip
rm -rf source-code-pro*

#gibo
smkdir ~/bin
curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so ~/bin/gibo && chmod +x ~/bin/gibo && ~/bin/gibo -u

# fasd
if ! fasd > /dev/null
then
    force-clone https://github.com/clvv/fasd.git ~/fasd
    cd ~/fasd && PREFIX=$HOME make install > /dev/null
    popd > /dev/null
    rm -rf ~/fasd
fi
