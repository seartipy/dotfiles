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

(require-package 'flx-ido)
(flx-ido-mode 1)

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
(setq-default js2-mode-display-warnings-and-errors nil)
(add-hook 'js2-mode-hook (lambda ()
                           (flycheck-mode 1)
          (js2-mode-hide-warnings-and-errors)))
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

(require-package 'jade-mode)

;;coffeescript settings
(custom-set-variables '(coffee-tab-width 2))
(setq coffee-args-compile '("-c" "-m")) ;; generating sourcemap
(add-hook 'coffee-after-compile-hook 'sourcemap-goto-corresponding-point)

;; If you want to remove sourcemap file after jumping corresponding point
(defun my/coffee-after-compile-hook (props)
  (sourcemap-goto-corresponding-point props)
  (delete-file (plist-get props :sourcemap)))
(add-hook 'coffee-after-compile-hook 'my/coffee-after-compile-hook)


(require-package 'fsharp-mode)

(require-package 'projectile)
(projectile-global-mode +1)
;; (require-package 'perspective)
;; (persp-mode)
;; (require-package 'projectile-rails)
;; (require-package 'persp-projectile)

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

(require-package 'wispjs-mode)

(require-package 'yasnippet)
(yas-global-mode 1)
(add-hook 'prog-mode-hook
          '(lambda ()
             (yas-minor-mode)))

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun rotate-windows ()
  "Rotate your windows"
  (interactive)
  (cond ((not (> (count-windows)1))
         (message "You can't rotate a single window!"))
        (t
         (setq i 1)
         (setq numWindows (count-windows))
         (while  (< i numWindows)
           (let* (
                  (w1 (elt (window-list) i))
                  (w2 (elt (window-list) (+ (% i numWindows) 1)))

                  (b1 (window-buffer w1))
                  (b2 (window-buffer w2))

                  (s1 (window-start w1))
                  (s2 (window-start w2))
                  )
             (set-window-buffer w1  b2)
             (set-window-buffer w2 b1)
             (set-window-start w1 s2)
             (set-window-start w2 s1)
             (setq i (1+ i)))))))

;; full screen magit-status

(require 'magit-key-mode)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

(require-package 'zeal-at-point)
(global-set-key "\C-cd" 'zeal-at-point)

(electric-pair-mode -1)

(require-package 'scala-mode2)
(require-package 'sbt-mode)
(require-package 'ensime)

(add-hook 'sbt-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-a") 'comint-bol)
             (local-set-key (kbd "M-RET") 'comint-accumulate)
             ))


(add-hook 'scala-mode-hook
          '(lambda ()
             (require-package 'flymake)
             (local-set-key (kbd "M-.") 'sbt-find-definitions)
             (local-set-key (kbd "C-x '") 'sbt-run-previous-command)
             ))
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(require-package 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(provide 'init-local)
;;; init-local.el ends here
