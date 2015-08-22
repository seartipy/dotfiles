if [ -e ~/.nvm ]; then
    source ~/.nvm/nvm.sh
fi

if ! nvm --version > /dev/null; then
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash
    source ~/.nvm/nvm.sh
fi
nvm install 0.12
nvm alias default 0.12
npm install -g coffee-script typescript babel
npm install -g grunt-cli gulp bower browserify webpack
npm install -g eslint eslint-plugin-react jshint coffeelint
npm install -g tern js-beautify
npm install -g react-tools
npm install -g webpack-dev-server

brew install flow
