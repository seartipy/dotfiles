# zeal
if ! ls /etc/apt/sources.list.d | grep zeal-developers-ubuntu > /dev/null; then
    sudo add-apt-repository ppa:zeal-developers/ppa -y # zeal
fi

# google chrome
if ! ls /etc/apt/sources.list.d | grep google.list > /dev/null; then
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
fi

# virtualbox
if [ ! $(vmwarectrl) ]; then
    if ! grep download.virtualbox.org/virtualbox/debian /etc/apt/sources.list > /dev/null; then
        wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
        sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian vivid contrib" >> /etc/apt/sources.list'
    fi
fi

# youtube-dl etc
if ! ls /etc/apt/sources.list.d | grep nilarimogard-ubuntu-webupd8 > /dev/null; then
    sudo add-apt-repository  ppa:nilarimogard/webupd8 -y
fi

# sublime text 3 editor
if ! ls /etc/apt/sources.list.d | grep webupd8team-ubuntu-sublime-text-3 > /dev/null; then
    sudo add-apt-repository ppa:webupd8team/sublime-text-3 -y
fi

# atom editor
if ! ls /etc/apt/sources.list.d | grep webupd8team-ubuntu-atom > /dev/null; then
    sudo add-apt-repository  ppa:webupd8team/atom -y
fi

sudo apt-get update

if [ ! $(vmwarectrl) ]; then
    sudo apt-get install -y virtualbox-5.0 dkms
fi

sudo apt-get install -y vlc
sudo apt-get install -y youtube-dl
sudo apt-get install -y sublime-text-installer
sudo apt-get install -y atom
sudo apt-get install -y zeal
sudo apt-get install -y google-chrome-stable

# source code pro fonts
if ! ls ~/.fonts | grep SourceCodePro > /dev/null; then
    wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
    unzip 1.030R-it.zip
    smkdir ~/.fonts
    cp source-code-pro*/OTF/*.otf ~/.fonts
    fc-cache -f -v
    rm -f 1.030R-it.zip
    rm -rf source-code-pro*
fi

#gibo
if [ ! $(which gibo) ]; then
    smkdir ~/bin
    curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so ~/bin/gibo && chmod +x ~/bin/gibo && ~/bin/gibo -u > /dev/null
fi

# fasd
if [ ! $(which fasd) ]; then
    force-clone https://github.com/clvv/fasd.git ~/fasd
    cd ~/fasd && PREFIX=$HOME make install > /dev/null
    rm -rf ~/fasd
fi
