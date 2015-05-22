(require-package 'flx-ido)
(flx-ido-mode 1)

;; tern setup for javascript autocompletionc
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

(require-package 'projectile)
(projectile-global-mode +1)

(require-package 'key-chord)
(require 'key-chord)
(key-chord-mode +1)

;;miscellaneous settings

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

(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))
(global-set-key (kbd "C-^") 'top-join-line)

(defun smart-kill-whole-line (&optional arg)
  "A simple wrapper around `kill-whole-line' that respects indentation."
  (interactive "P")
  (kill-whole-line arg)
  (back-to-indentation))
(global-set-key [remap kill-whole-line] 'smart-kill-whole-line)

;; disable auto-save
(setq auto-save-default nil)

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
(key-chord-define-global "zz" 'zop-up-to-char)

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

(require-package 'clojure-quick-repls)

(require-package 'ace-window)
(global-set-key (kbd "C-,") 'ace-window)
(ace-window-display-mode)

(require-package 'hydra)

(require-package 'avy)
(avy-setup-default)

(global-set-key (kbd "M-g c") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)

(set-face-attribute 'aw-leading-char-face nil :foreground "deep sky blue" :weight 'bold :height 3.0)
(set-face-attribute 'aw-mode-line-face nil :inherit 'mode-line-buffer-id :foreground "lawn green")
(setq ;; aw-keys   '(?a ?s ?d ?f ?j ?k ?l)
 aw-dispatch-always t
 aw-dispatch-alist
 '((?x aw-delete-window     "Ace - Delete Window")
   (?c aw-swap-window       "Ace - Swap Window")
   (?n aw-flip-window)?
   (?v aw-split-window-vert "Ace - Split Vert Window")
   (?h aw-split-window-horz "Ace - Split Horz Window")
   (?m delete-other-windows "Ace - Maximize Window")
   (?g delete-other-windows)
   (?b balance-windows)
   (?u winner-undo)
   (?r winner-redo)))

(when (package-installed-p 'hydra)
  (defhydra hydra-window-size (:color red)
    "Windows size"
    ("h" shrink-window-horizontally "shrink horizontal")
    ("j" shrink-window "shrink vertical")
    ("k" enlarge-window "enlarge vertical")
    ("l" enlarge-window-horizontally "enlarge horizontal"))
  (defhydra hydra-window-frame (:color red)
    "Frame"
    ("f" make-frame "new frame")
    ("x" delete-frame "delete frame"))
  (defhydra hydra-window-scroll (:color red)
    "Scroll other window"
    ("n" joe-scroll-other-window "scroll")
    ("p" joe-scroll-other-window-down "scroll down"))
  (add-to-list 'aw-dispatch-alist '(?w hydra-window-size/body) t)
  (add-to-list 'aw-dispatch-alist '(?o hydra-window-scroll/body) t)
  (add-to-list 'aw-dispatch-alist '(?\; hydra-window-frame/body) t))
(ace-window-display-mode t)

(global-unset-key (kbd "C-z")) ;;disable minimize

(require-package 'lispy)
(add-hook 'emacs-lisp-mode-hook  (lambda () (lispy-mode 1)))


(require-package 'workgroups2)
(workgroups-mode 1)

(require-package 'back-button)
(back-button-mode 1)

(require-package 'neotree)
(global-set-key [f8] 'neotree-toggle)

(require-package 'direx)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)

(require-package 'web-beautify)
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

(require-package 'discover-my-major)

(require-package 'easy-kill)
(global-set-key [remap kill-ring-save] 'easy-kill)

(require-package 'god-mode)
(global-set-key (kbd "<escape>") 'god-local-mode)

(require-package 'ov)

(require-package 'move-text)
(move-text-default-bindings)

(require-package 'volatile-highlights)
(require 'volatile-highlights)
(volatile-highlights-mode t)

(require-package 'zop-to-char)
(global-set-key [remap zap-to-char] 'zop-to-char)

(require-package 'gist)

(provide 'init-local)
;;; init-local.el ends here
