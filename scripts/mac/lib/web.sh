##### Javascript

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 0.12
nvm alias default 0.12
source ~/.nvm/nvm.sh
npm install -g coffee-script typescript babel
npm install -g grunt-cli gulp bower browserify webpack
npm install -g tap karma-cli jest jshint coffeelint
npm install -g jstransform react-tools
git clone https://github.com/marijnh/tern.git ~/tern && cd ~/tern && npm install
brew install flow
