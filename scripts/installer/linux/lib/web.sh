#### javascript

if ! nvm -v > /dev/null; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash
    source ~/.nvm/nvm.sh
fi
nvm install 0.12
nvm alias default 0.12
npm install -g coffee-script typescript babel
npm install -g grunt-cli gulp bower browserify webpack
npm install -g eslint esline-plugin-react jshint coffeelint
npm install -g tern js-beautify
npm install -g react-tools
npm install -g webpack-dev-server

sclone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install
popd

if ! flow -v > /dev/null; then
    cd $SEARTIPY_HOME/vendors
    wget https://facebook.github.io/flow/downloads/flow-linux64-latest.zip
    unzip flow*.zip
    cd flow
    echo -e "\nPATH=\"\$PATH:$(pwd)/\"" >> ~/.bashrc && source ~/.bashrc
    popd
    popd
fi
