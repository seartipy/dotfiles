#### javascript

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 0.12
nvm alias default 0.12
npm install -g coffee-script typescript babel grunt-cli gulp bower browserify webpack jshint coffeelint jstransform react-tools eslint esline-plugin-react

git clone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install
popd

cd $SEARTIPY_HOME/vendors
wget https://facebook.github.io/flow/downloads/flow-linux64-latest.zip
unzip flow*.zip
cd flow
echo -e "\nPATH=\"\$PATH:$(pwd)/\"" >> ~/.bashrc && source ~/.bashrc
popd
