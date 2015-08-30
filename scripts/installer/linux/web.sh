if [ ! $(which nvm > /dev/null) ]; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash
    source ~/.nvm/nvm.sh
fi
nvm install stable

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

if [ ! $(which flow) ]; then
    cd $SEARTIPY_HOME/vendors
    wget https://facebook.github.io/flow/downloads/flow-linux64-latest.zip
    unzip flow*.zip
fi
