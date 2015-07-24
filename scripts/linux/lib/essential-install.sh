#### dotfiles

git clone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles
mkdir ~/bin

#### bash

git clone https://github.com/nojhan/liquidprompt.git ~/liquidprompt
echo "[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt" >> ~/.bashrc

#### zsh

# In gnome terminal profile preferences, select 'Run command as a login shell

git clone https://github.com/zsh-users/antigen.git ~/antigen
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup
ln -s ~/dotfiles/common/zshrc ~/.zshrc
ln -s ~/dotfiles/common/tmux.conf ~/.tmux.conf

#### git

cp ~/dotfiles/common/gitconfig ~/.gitconfig

#### emacs

git clone --recursive https://github.com/syl20bnr/spacemacs ~/spacemacs
git clone https://github.com/pervezfunctor/emacs.d.git ~/housem.d
ln -s ~/housem.d ~/.emacs.d

#### vim

curl http://j.mp/spf13-vim3 -L -o - | sh

#### misceleanous

curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so ~/bin/gibo && chmod +x ~/bin/gibo && ~/bin/gibo -u
git clone https://github.com/clvv/fasd.git ~/fasd
pushd . && cd ~/fasd && PREFIX=$HOME make install && popd

#### source code pro fonts

wget https://github.com/adobe-fonts/source-code-pro/archive/2.010R-ro/1.030R-it.zip
unzip 1.030R-it.zip
mkdir ~/.fonts
cp source-code-pro*/OTF/*.otf ~/.fonts
fc-cache -f -v
rm -f 1.030R-it.zip
rm -rf source-code-pro*

## external commands
emacs&
chsh -s /bin/zsh
