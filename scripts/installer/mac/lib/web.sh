##### Javascript

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 0.12
nvm alias default 0.12
source ~/.nvm/nvm.sh
npm install -g coffee-script typescript babel grunt-cli gulp bower browserify webpack jshint coffeelint jstransform react-tools
pushd .
git clone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install
popd
brew install flow
