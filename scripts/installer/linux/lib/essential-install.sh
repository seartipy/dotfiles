# START WITH SOURCING ZSHRC

sclone https://github.com/pervezfunctor/dotfiles.git ~/dotfiles
smkdir ~/bin
sclone https://github.com/nojhan/liquidprompt.git ~/liquidprompt
safe-append "[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt" ~/.bashrc liquidprompt
sclone https://github.com/zsh-users/antigen.git ~/antigen

sln ~/dotfiles/common/zshrc ~/.zshrc
sln ~/dotfiles/common/tmux.conf ~/.tmux.conf

[ -e ~/.gitconfig ] || cp ~/dotfiles/common/gitconfig ~/.gitconfig

#### zsh

# In gnome terminal profile preferences, select 'Run command as a login shell

git clone https://github.com/zsh-users/antigen.git ~/antigen
[ -e ~/.zshrc ] && mv -b ~/.zshrc ~/.zshrc-backup
ln -s ~/dotfiles/common/zshrc ~/.zshrc
ln -s ~/dotfiles/common/tmux.conf ~/.tmux.conf

#### git

cp ~/dotfiles/common/gitconfig ~/.gitconfig

#### emacs

git clone --recursive https://github.com/syl20bnr/spacemacs ~/.spacemacs
git clone https://github.com/pervezfunctor/emacs.d.git ~/housem.d
ln -s ~/housem.d ~/.emacs.d
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
pushd .
cd ~/housem.d && ~/.cask/bin/cask install
popd

#### misceleanous

sclone https://github.com/syl20bnr/spacemacs ~/spacemacs --recursive
sclone https://github.com/pervezfunctor/emacs.d.git ~/housem.d
sln ~/housem.d ~/.emacs.d

curl -L https://raw.github.com/simonwhitaker/gibo/master/gibo -so ~/bin/gibo && chmod +x ~/bin/gibo && ~/bin/gibo -u

if ! fasd > /dev/null
then
    force-clone https://github.com/clvv/fasd.git ~/fasd
    pushd . > /dev/null
    cd ~/fasd && PREFIX=$HOME make install > /dev/null
    popd > /dev/null
    rm -rf ~/fasd
fi
