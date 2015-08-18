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
    pushd . > /dev/null
    cd ~/fasd && PREFIX=$HOME make install > /dev/null
    popd > /dev/null
    rm -rf ~/fasd
fi