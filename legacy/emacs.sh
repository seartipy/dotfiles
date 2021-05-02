# emacs

seartipy_kill_emacs() {
    emacsclient -e "(progn (setq kill-emacs-hook nil) (save-buffers-kill-emacs '(4)))"
}

seartipy_emacs_upgrade() {
    emacs -batch --eval "(progn (load-file \"~/.emacs.d/init.el\") (package-refresh-contents) (auto-package-update-now) (package-autoremove)"
}

seartipy_emacs_clean() {
    srm ~/.emacs.d/.cache ~/.emacs.d/auto-save-list ~/.emacs.d/.last-package-update-day
}

#emacs
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate
