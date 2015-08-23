if ! nvm --version > /dev/null; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash
    source ~/.nvm/nvm.sh
fi
nvm install 0.12
nvm alias default 0.12
npm install -g coffee-script
npm install -g typescript babel
npm install -g grunt-cli
npm install -g gulp
npm install -g bower
npm install -g browserify
npm install -g webpack
npm install -g eslint
npm install -g eslint-plugin-react
npm install -g jshint
npm install -g coffeelint
npm install -g tern
npm install -g js-beautify
npm install -g react-tools
npm install -g webpack-dev-server

pushd .
sclone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install
popd > /dev/null

if ! flow -v > /dev/null; then
    pushd . > /dev/null
    cd $SEARTIPY_HOME/vendors
    wget https://facebook.github.io/flow/downloads/flow-linux64-latest.zip
    unzip flow*.zip
    pushd .
    popd > /dev/null
fi
