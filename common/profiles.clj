{:user {
        :plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"] ; nrepl server for cider in emacs
                  [refactor-nrepl "1.2.0-SNAPSHOT"] ; refactor in emacs using clj-refactor
                  [com.jakemccrary/lein-test-refresh "0.10.0"]
                  [lein-midje "3.1.4-SNAPSHOT"] ; midje plugin for continous testing
                  [lein-exec "0.3.5"] ; run clojure scripts
                  [lein-try "0.4.3"] ; try clojure library
                  [lein-oneoff "0.3.1"] ; run single clojure script
                  [lein-cprint "1.1.0"] ; Like lein-pprint, but with colorization!
                  [quickie "0.4.0"] ; Lein plugin for auto testing
                  [venantius/ultra "0.3.4"] ; A Leiningen plugin for a superior development environment
                  [alembic "0.3.2"] ; A library for distilling dependencies
                  [lein-ancient "0.6.8-SNAPSHOT"]] ; upgrade packages
        :ultra {:color-scheme :solarized_dark}
        :dependencies [[org.clojure/tools.nrepl "0.2.10"]
                       [acyclic/squiggly-clojure "0.1.3-SNAPSHOT"]]}} ; flycheck using eastwood
