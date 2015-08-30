if [ ! $(which rvm) ]; then
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    source ~/.rvm/scripts/rvm
fi

gem install pry sinatra thin --no-ri --no-rdoc
gem install guard watchr --no-ri --no-rdoc
gem install tmuxinator git-up sass --no-ri --no-rdoc
