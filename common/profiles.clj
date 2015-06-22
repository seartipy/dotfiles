{:user {
        :plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]
                  [refactor-nrepl "1.0.5"]
                  [com.jakemccrary/lein-test-refresh "0.10.0"]
                  [lein-ancient "0.6.7"]
                  [jonase/eastwood "0.2.1"]
                  [lein-midje "3.1.3"]
                  [lein-exec "0.3.5"]
                  [lein-try "0.4.3"]
                  [lein-oneoff "0.3.1"]
                  [lein-cprint "1.1.0"]
                  [quickie "0.3.6"]
                  [venantius/ultra "0.3.3"]]
        :ultra {:color-scheme :solarized_dark}
        :injections [(require 'pjstadig.humane-test-output)
                     (pjstadig.humane-test-output/activate!)]
        :dependencies [[pjstadig/humane-test-output "0.6.0"]
                       [org.clojure/tools.nrepl "0.2.10"]]}}
