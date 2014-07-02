;; C++ configuration
(require-package 'company)
(setq company-clang-arguments
     '("-std=c++11"
       "-stdlib=libc++"
       "-I/usr/include/c++/v1"
       "-I/usr/include"
       "-I/usr/include/x86_64-linux-gnu"
       "-I/usr/include/clang/3.4/include/"))

(setq flycheck-clang-language-standard "c++11")
(setq flycheck-clang-standard-library "libc++")

(semantic-mode +1)
(require 'semantic/bovine/gcc)

;; tern setup for javascript autocompletion
(add-to-list 'load-path "~/tern/emacs")
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;;run javascript from within emacs using skewer-mode.
(add-hook 'js2-mode-hook 'skewer-mode)
(add-hook 'css-mode-hook 'skewer-css-mode)
(add-hook 'html-mode-hook 'skewer-html-mode)

;;enable flycheck instead of js2
(setq-default js2-show-parse-errors nil)
(setq-default js2-strict-missing-semi-warning nil)
(setq-default js2-strict-trailing-comma-warning t)
(add-hook 'js2-mode-hook (lambda () (flycheck-mode 1)))
(setq js2-basic-offset 4) ;; I like 4 spaces in javascript code

;; refactoring support for javascript
(require-package 'js2-refactor)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-m")
(require 'js2-imenu-extras)
(js2-imenu-extras-setup)
;; Use lambda for anonymous functions
(font-lock-add-keywords
 'js2-mode `(("\\(function\\) *("
              (0 (progn (compose-region (match-beginning 1)
                                        (match-end 1) "\u0192")
                        nil)))))

;;emmet-mode setup for emmet support in html/css files
(require-package 'emmet-mode)
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 4)))
(setq emmet-move-cursor-between-quotes t)

(require-package 'fsharp-mode)

(require-package 'jade-mode)

(require-package 'key-chord)
(require 'key-chord)
(key-chord-mode +1)

;;miscellaneous settings

(defun goto-line-with-feedback ()
  "Show line numbers temporarily, while prompting for the line number input"
  (interactive)
  (unwind-protect
      (progn
        (linum-mode 1)
        (goto-line (read-number "Goto line: ")))
    (linum-mode -1)))

(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; (defun top-join-line ()
;;   "Join the current line with the line beneath it."
;;   (interactive)
;;   (delete-indentation 1))
;;(global-set-key (kbd "C-^") 'top-join-line)

(defun smart-kill-whole-line (&optional arg)
  "A simple wrapper around `kill-whole-line' that respects indentation."
  (interactive "P")
  (kill-whole-line arg)
  (back-to-indentation))
(global-set-key [remap kill-whole-line] 'smart-kill-whole-line)

;; disable auto-save
(setq auto-save-default nil)

;; store all backup and autosave files in the tmp dir
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))

(defun visit-term-buffer ()
  "Create or visit a terminal buffer."
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
        (split-window-sensibly (selected-window))
        (other-window 1)
        (ansi-term (getenv "SHELL")))
    (switch-to-buffer-other-window "*ansi-term*")))

(menu-bar-mode -1)
(windmove-default-keybindings)
(electric-indent-mode t)
(global-set-key [remap goto-line] 'goto-line-with-feedback)
(setq ido-create-new-buffer 'always)
(add-hook 'prog-mode-hook 'subword-mode)
(setq create-lockfiles nil)

(require-package 'buffer-move)
(require 'buffer-move)

(require-package 'multi-term)
(require 'multi-term)

(setq multi-term-scroll-to-bottom-on-output "others")
(setq multi-term-scroll-show-maximum-output +1)

(require-package 'ido-vertical-mode)
(ido-vertical-mode +1)

(require-package 'editorconfig)
(require-package 'monokai-theme)

;;key bindings

(define-key global-map [?\s-g] 'goto-line)

(key-chord-define-global "jj" 'ace-jump-mode)
(key-chord-define-global "zz" 'zap-up-to-char)

(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)

(global-set-key [(control shift return)] 'smart-open-line-above)

(global-set-key (kbd "M-o") 'smart-open-line)
(global-set-key (kbd "M-O") 'smart-open-line-above)
(global-set-key (kbd "C-c s") 'just-one-space)
(global-set-key (kbd "C-x p") 'proced)
(global-set-key (kbd "C-c b") 'switch-to-previous-buffer)
(global-set-key (kbd "C-x C-r") 'sudo-edit)

(global-set-key
 (kbd "C-<backspace>")
 (lambda ()
   (interactive)
   (kill-line 0)
   (indent-according-to-mode)))

(setq flycheck-check-syntax-automatically '(new-line save mode-enabled))

(require-package 'git-gutter)
(global-git-gutter-mode t)

(setq git-gutter:modified-sign "~") ;; two space
(setq git-gutter:hide-gutter t)
(global-set-key (kbd "C-x C-g") 'git-gutter:toggle)
(global-set-key (kbd "C-x v =") 'git-gutter:popup-hunk)

;; Jump to next/previous hunk

(global-set-key (kbd "C-x p") 'git-gutter:previous-hunk)
(global-set-key (kbd "C-x n") 'git-gutter:next-hunk)

;; Stage current hunk
(global-set-key (kbd "C-x v s") 'git-gutter:stage-hunk)

;; Revert current hunk
(global-set-key (kbd "C-x v r") 'git-gutter:revert-hunk)

(require-package 'wispjs-mode)

(require-package 'yasnippet)
(yas-global-mode 1)
(add-hook 'prog-mode-hook
          '(lambda ()
             (yas-minor-mode)))

(provide 'init-local)
;;; init-local.el ends here
