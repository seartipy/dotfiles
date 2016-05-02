(require 'boot.repl)

(swap! boot.repl/*default-dependencies*
       concat '[[refactor-nrepl "2.3.0-SNAPSHOT"]
                [org.clojure/tools.nrepl "0.2.12-SNAPSHOT"]
                [cider/cider-nrepl "0.12.0-SNAPSHOT"]])

(swap! boot.repl/*default-middleware*
       conj 'cider.nrepl/cider-middleware)


(swap! boot.repl/*default-middleware* conj
       'refactor-nrepl.middleware/wrap-refactor)

;; (set-env! :dependencies #(conj % '[spyscope "0.1.5"]))
;; (require 'spyscope.core)
;; (boot.core/load-data-readers!)

(deftask cider "CIDER profile"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat '[[refactor-nrepl "2.3.0-SNAPSHOT"]
                  [org.clojure/tools.nrepl "0.2.12-SNAPSHOT"]
                  [cider/cider-nrepl "0.12.0-SNAPSHOT"]])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  refactor-nrepl.middleware/wrap-refactor])
  identity)
