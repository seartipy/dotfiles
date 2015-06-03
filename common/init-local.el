(add-to-list 'load-path (expand-file-name "more-lisp" user-emacs-directory))

(require 'more-misc)
(require 'more-editing-utils)
(require 'more-window)
(require 'more-buffer)

(require 'more-term)
(require 'more-git)
(require 'more-ide)

(require 'more-web)
(require 'more-clojure)
(require 'more-scala)
(require 'more-python)

(require 'more-keys)

(require-package 'ein)

(provide 'init-local)
;;; init-local.el ends here
