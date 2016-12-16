{:user {
        :plugins [[com.jakemccrary/lein-test-refresh "0.18.0"]
                  [lein-exec "0.3.6"] ; run clojure scripts
                  [lein-try "0.4.3"] ; try clojure library
                  [lein-oneoff "0.3.2"] ; run single clojure script
                  [lein-cprint "1.2.0"] ; Like lein-pprint, but with colorization!
                  [quickie "0.4.2"] ; Lein plugin for auto testing
                  [venantius/ultra "0.5.0"] ; A Leiningen plugin for a superior development environment
                  [lein-ancient "0.6.10"] ; upgrade packages
                  ]
        :dependencies [[spyscope "0.1.5"] ; lodash tap like macro
                       [acyclic/squiggly-clojure "0.1.6"] ; flycheck using eastwood
                       ]
        :injections [(require 'spyscope.core)
                     ]}}
