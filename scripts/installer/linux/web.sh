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

pushd .
sclone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install
popd > /dev/null

if ! flow -v > /dev/null; then
    pushd .
    cd $SEARTIPY_HOME/vendors
    wget https://facebook.github.io/flow/downloads/flow-linux64-latest.zip
    unzip flow*.zip
    pushd .
    popd > /dev/null
fi
