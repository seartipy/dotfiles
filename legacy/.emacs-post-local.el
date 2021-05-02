(use-package shackle
  :defer t
  :init
  (setq shackle-rules '((compilation-mode :noselect t))
        shackle-default-rule '(:algin 'below)))

;; (use-package speed-type :defer t)
(use-package comint
  :ensure nil
  :init

  (add-to-list 'comint-preoutput-filter-functions
               (lambda (output)
                 (let ((case-fold-search nil))
                   (replace-regexp-in-string "\033\\[[0-9]+[A-Z]" "" output)))))

(use-package visual-regexp :defer t)
(use-package ejc-sql :defer t)

;; (use-package jabber
;;   :defer t

;;   :init
;;   (defun seartipy/jabber-connect-hook (jc)
;;     (jabber-send-presence "" "Online" 10)
;;     (jabber-whitespace-ping-start)
;;     ;; Disable the minibuffer getting jabber messages when active
;;     ;; See http://www.emacswiki.org/JabberEl
;;     (define-jabber-alert echo "Show a message in the echo area"
;;       (lambda (msg)
;;         (unless (minibuffer-prompt)
;;           (message "%s" msg)))))
;;   (add-hook 'jabber-post-connect-hooks 'seartipy/jabber-connect-hook)

;;   (evil-leader/set-key "aj" 'jabber-connect-all)

;;   :config
;;   (evil-leader/set-key-for-mode jabber-roster-mode
;;     "a" 'jabber-send-presence
;;     "b" 'jabber-get-browse
;;     "d" 'jabber-disconnect
;;     "e" 'jabber-roster-edit-action-at-point
;;     "g" 'jabber-display-roster
;;     "i" 'jabber-get-disco-items
;;     "j" 'jabber-muc-join
;;     "q" 'bury-buffer
;;     "r" 'jabber-roster-toggle-offline-display
;;     "s" 'jabber-send-subscription-request
;;     "v" 'jabber-get-version
;;     "RET" 'jabber-roster-ret-action-at-point))

;; (when (file-exists-p "~/.emacs-private.el")
;;   (load-file "~/.emacs-private.el"))
