;;; Generic emacs settings I cannot live without

;; Use command as the meta key; option key as super
(setq ns-command-modifier 'meta)
(setq ns-option-modifier  'super)

;; Don't show the startup screen
(setq inhibit-startup-message t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)
(pending-delete-mode t)

;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)

;; Modeline info
;; (display-time-mode 1)
;; (display-battery-mode 1)

;; Small fringes
(set-fringe-mode '(1 . 1))

;; Emacs gurus don't need no stinking scroll bars
(when (fboundp 'toggle-scroll-bar)
  (toggle-scroll-bar -1))

;; Explicitly show the end of a buffer
(set-default 'indicate-empty-lines t)

;; Line-wrapping
(set-default 'fill-column 78)

;; Prevent the annoying beep on errors
;; (setq visible-bell t)

;; Make sure all backup files only live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Gotta see matching parens
(show-paren-mode t)

;; Don't truncate lines
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

;; For emacsclient
(server-start)

;; Trailing whitespace is unnecessary
(defvar whitespace-cleanup-on-save t
  "Cleanup whitespace before save")
(setq whitespace-cleanup-on-save t)
(make-variable-buffer-local 'whitespace-cleanup-on-save)
;; (setq whitespace-cleanup-on-save nil)
(add-hook 'before-save-hook
          (lambda ()
            (if whitespace-cleanup-on-save (whitespace-cleanup))))

;; Fix bug in whitespace cleanup to actually check indent-tabs-mode
(defadvice whitespace-cleanup (around whitespace-cleanup-indent-tab
                                      activate)
  "Fix whitespace-cleanup indent-tabs-mode bug"
  (let ((whitespace-indent-tabs-mode indent-tabs-mode)
        (whitespace-tab-width tab-width))
    ad-do-it))

;; Trash can support
(setq delete-by-moving-to-trash t)

;; `brew install aspell --lang=en` (instead of ispell)
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; zap-up-to-char, forward-to-word, backward-to-word, etc
(require 'misc)
