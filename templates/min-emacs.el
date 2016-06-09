;; prefer UTF8

(setq user-emacs-directory "~/.min-emacs.d")

(unless (file-exists-p user-emacs-directory)
  (make-directory user-emacs-directory t))

(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(defconst seartipy-cache-directory
  (expand-file-name (concat user-emacs-directory ".cache/"))
  "storage area for persistent files")

(unless (file-exists-p seartipy-cache-directory)
  (make-directory seartipy-cache-directory t))

(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-a-linux* (eq system-type 'gnu/linux))

(setq custom-file (expand-file-name "custom.el" seartipy-cache-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; misc

(when *is-a-mac*
  (setq mac-option-modifier 'meta))

(setq-default
 bookmark-default-file (expand-file-name ".bookmarks.el" seartipy-cache-directory)
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 delete-selection-mode t
 indent-tabs-mode nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 show-trailing-whitespace t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil
 visible-bell t)

(transient-mark-mode t)

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

(setq indicate-empty-lines t)
(tool-bar-mode -1)
(set-scroll-bar-mode nil)
(menu-bar-mode -1)

(add-hook 'term-mode-hook
          (lambda ()
            (setq line-spacing 0)))

(electric-indent-mode t)
(setq create-lockfiles nil)
(fset 'yes-or-no-p 'y-or-n-p)

;; do not ask follow link
(setq find-file-visit-truename t)

;; do not ask to kill processes
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  (cl-flet ((process-list ())) ad-do-it))

(windmove-default-keybindings)
(winner-mode)
(cua-selection-mode t)

;; Don't disable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
;; Don't disable case-change functions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(show-paren-mode 1)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; MELPA

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-always-ensure t)
(require 'use-package)

;;;; UI

(use-package spacemacs-theme :defer t)
(load-theme 'spacemacs-dark t)


(when *is-a-mac*
  (set-default-font "Monaco 13"))

(when *is-a-linux*
  (set-default-font "Ubuntu Mono 13"))

;; Essential

(use-package auto-compile
  :config
  (auto-compile-on-load-mode))

(use-package savehist
  :init
  (setq savehist-file (concat seartipy-cache-directory "savehist")
        enable-recursive-minibuffers t ; Allow commands in minibuffers
        history-length 1000
        savehist-additional-variables '(mark-ring
                                        global-mark-ring
                                        search-ring
                                        regexp-search-ring
                                        extended-command-history)
        savehist-autosave-interval 60)
  (savehist-mode t))

(use-package saveplace
  :init
  (setq save-place t
        save-place-file (concat seartipy-cache-directory "places")))


(use-package recentf
  :config
  (setq recentf-save-file (concat seartipy-cache-directory "recentf"))
  (setq recentf-max-saved-items 100)
  (setq recentf-auto-save-timer (run-with-idle-timer 600 t 'recentf-save-list)))


;;;; keybindings management packages

(use-package which-key
  :diminish which-key-mode
  :init
  (which-key-mode))


;;;; IDO

(use-package ido
  :init
  (customize-set-variable 'ido-save-directory-list-file
                          (concat seartipy-cache-directory "ido-last"))
  (setq ido-enable-flex-matching t)
  (setq ido-use-filename-at-point nil)
  (setq ido-auto-merge-work-directories-length 0)
  (setq ido-use-virtual-buffers t)
  (setq ido-create-new-buffer 'always)
  :config
  (ido-mode)
  (ido-everywhere))

(use-package ido-ubiquitous
  :config
  (ido-ubiquitous-mode))

(use-package smex
  :init
  ;; Change path for ~/.smex-items
  (setq smex-save-file (expand-file-name ".smex-items" seartipy-cache-directory))
  :config
  (bind-key [remap execute-extended-command] 'smex))

(use-package flx-ido
  :config
  (flx-ido-mode))


;;;; Window management

(use-package window-numbering
  :config
  (window-numbering-mode))

(use-package uniquify
  :ensure nil
  :init
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets
        uniquify-ignore-buffers-re "^\\*"))

;; Search

(use-package avy
  :bind ("C-'" . avy-goto-word-or-subword-1)
  :init
  (setq avy-keys (number-sequence ?a ?z))
  (setq avy-background t))

(use-package ag
  :commands (ag ag-files ag-regexp ag-project ag-dired)
  :bind ("M-?" . ag-project)
  :config (setq ag-highlight-search t
                ag-reuse-buffers t))

(use-package wgrep)

(use-package wgrep-ag
  :defer t
  :init
  (autoload 'wgrep-ag-setup "wgrep-ag"))

;;;; Editing

(use-package whitespace-cleanup-mode
  :diminish whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode))

(dolist (hook '(special-mode-hook
                Info-mode-hook
                eww-mode-hook
                term-mode-hook
                comint-mode-hook
                compilation-mode-hook
                magit-popup-mode-hook
                minibuffer-setup-hook))
  (add-hook hook (lambda ()
                   (setq show-trailing-whitespace nil))))

(bind-key [remap just-one-space] 'cycle-spacing)
(bind-key "RET" 'newline-and-indent)

(use-package iedit :diminish iedit-mode)


;;;; Git

(use-package magit
  :bind ("C-x g" . magit-status)
  :init
  (setq-default
   magit-log-arguments '("--graph" "--show-signature")
   magit-process-popup-time 10
   magit-diff-refine-hunk t
   magit-push-always-verify nil)
  :config
  (global-git-commit-mode))

(use-package ediff
  :defer t
  :init
  (setq-default
   ediff-window-setup-function 'ediff-setup-windows-plain
   ediff-split-window-function 'split-window-horizontally
   ediff-merge-split-window-function 'split-window-horizontally))


;;;; Programming

(use-package eldoc
  :defer t
  :diminish eldoc-mode
  :config
  (add-hook 'eval-expression-minibuffer-setup-hook #'eldoc-mode)
  (add-hook 'ielm-mode-hook #'eldoc-mode))

(use-package exec-path-from-shell
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize)
  (dolist (var '("SSH_AUTH_SOCK" "SSH_AGENT_PID" "GPG_AGENT_INFO" "LANG" "LC_CTYPE" "JAVA_HOME" "JDK_HOME"))
    (add-to-list 'exec-path-from-shell-variables var)))

(use-package flycheck
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq flycheck-check-syntax-automatically '(save new-line mode-enabled)
        flycheck-idle-change-delay 0.8)
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list))

(use-package company
  :diminish company-mode " ⓐ"
  :commands (company-mode)
  :init
  (setq company-idle-delay 0.5
        company-tooltip-limit 10
        company-minimum-prefix-length 2
        company-tooltip-flip-when-above t)
  :config
  (setq company-minimum-prefix-length 2))

(use-package smartparens
  :defer t
  :diminish smartparens-mode " ⓟ"
  :init
  (setq sp-show-pair-delay 0
        sp-show-pair-from-inside nil
        sp-base-key-bindings 'paredit
        sp-autoskip-closing-pair 'always
        sp-hybrid-kill-entire-symbol nil
        sp-cancel-autoskip-on-backward-movement nil)
  :config
  (require 'smartparens-config)
  (sp-use-paredit-bindings)
  (add-hook 'emacs-lisp-mode-hook #'smartparens-strict-mode))

(use-package rainbow-delimiters
  :defer t
  :diminish rainbow-delimiters-mode)

(use-package aggressive-indent
  :defer t
  :diminish aggressive-indent-mode " Ⓘ")


(require 'init-local nil t)

;; ;;; init.el ends here
