{:user {
        :plugins [
                  [cider/cider-nrepl "0.14.0-SNAPSHOT"] ; nrepl server for cider in emacs
                  [refactor-nrepl "2.3.0-SNAPSHOT"] ; refactor in emacs using clj-refactor
                  [com.jakemccrary/lein-test-refresh "0.17.0"]
                  [lein-midje "3.2.1"] ; midje plugin for continous testing
                  [lein-exec "0.3.6"] ; run clojure scripts
                  [lein-try "0.4.3"] ; try clojure library
                  [lein-oneoff "0.3.2"] ; run single clojure script
                  [lein-cprint "1.2.0"] ; Like lein-pprint, but with colorization!
                  [quickie "0.4.2"] ; Lein plugin for auto testing
                  [venantius/ultra "0.4.1"] ; A Leiningen plugin for a superior development environment
                  [lein-ancient "0.6.10"]] ; upgrade packages
        :ultra {:color-scheme :solarized_dark}
        :dependencies [[org.clojure/tools.nrepl "0.2.12"]
                       [spyscope "0.1.5"] ; lodash tap like macro
                       [im.chit/vinyasa "0.4.7"]
                       [acyclic/squiggly-clojure "0.1.6"]] ; flycheck using eastwood
        :injections [(require 'spyscope.core)
                     (require 'io.aviso.repl)
                     (require '[vinyasa.inject :as inject])
                     (inject/in [vinyasa.inject :refer [inject [in inject-in]]]
                                clojure.core
                                [vinyasa.reflection .> .? .* .% .%> .& .>ns .>var]

                                ;; inject into clojure.core with prefix
                                clojure.core >
                                [clojure.pprint pprint]
                                [clojure.java.shell sh]
                                [clojure.repl doc source]
                                [clojure.pprint pprint pp]
                                )]}}
