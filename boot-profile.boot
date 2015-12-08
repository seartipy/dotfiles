(require 'boot.repl)

(swap! boot.repl/*default-dependencies* conj
       '[refactor-nrepl "2.0.0-SNAPSHOT"]
       '[org.clojure/tools.nrepl "0.2.12"]
       '[cider/cider-nrepl "0.11.0-SNAPSHOT"])

(swap! boot.repl/*default-middleware*
       conj 'cider.nrepl/cider-middleware)


(swap! boot.repl/*default-middleware* conj
       'refactor-nrepl.middleware/wrap-refactor)
