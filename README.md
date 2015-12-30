This repository consists of configuration for zsh, emacs, clojure, scala, haskell web development and more.

### Installation

#### Automated install

Automated installer script will work only with the latest Ubuntu and Mac operating systems.

##### Linux

1. **Clojure**

        wget -qO- j.mp/seartipy-setup > ~/setup && bash ~/setup clojure

2. **Scala**

		wget -qO- j.mp/seartipy-setup > ~/setup && bash ~/setup scala

3. **Web**

		wget -qO- j.mp/seartipy-setup > ~/setup && bash ~/setup web

4. **Everything**

		wget -qO- j.mp/seartipy-setup > ~/setup && bash ~/setup everything

##### Mac

1. **Clojure**

		curl -L http://bit.ly/1NXq6Pp > ~/setup && bash ~/setup clojure

2. **Scala**

		curl -L j.mp/seartipy-setup > ~/setup && bash ~/setup scala

3. **Web**

		curl -L j.mp/seartipy-setup > ~/setup && bash ~/setup web

4. **Everything**

		curl -L j.mp/seartipy-setup > ~/setup && bash ~/setup

**Please Note** :

* No files will be deleted by the installer. All your current files will be backed up to ~/seartipy.backups directory.

* If ~/seartipy.backups already exists, it will be moved to trash. Also, if you find a file deleted but do not find it in ~/seartipy.backups, you should find it in  your trash folder.
