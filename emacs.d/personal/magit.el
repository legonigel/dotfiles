;;; It's Magit! An Emacs mode for Git.

(require 'magit)

(add-to-list 'load-path "~/.emacs.d/vendor/git-modes")

(add-hook
 'magit-mode-hook
 (lambda ()
   (yas-minor-mode -1)))

;; full screen magit-status
;; borrowed from http://whattheemacsd.com/setup-magit.el-01.html
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

;; show submodules on magit status
(magit-add-section-hook 'magit-status-sections-hook
                        'magit-insert-modules
                        'magit-insert-stashes
                        nil)
(setq magit-module-sections-hook
        '(magit-insert-modules-overview
          magit-insert-modules-unpulled-from-upstream
          magit-insert-modules-unpushed-to-upstream))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(eval-after-load 'magit
  '(progn
     ;(set-face-background 'magit-item-highlight "#3f4747")
     ;(set-face-foreground 'magit-item-highlight nil)
     ;(set-face-underline  'magit-item-highlight nil)
     (define-key magit-mode-map (kbd "M-3") 'split-window-horizontally) ; was magit-show-level-3
     (define-key magit-mode-map (kbd "M-2") 'split-window-vertically)   ; was magit-show-level-2
     (define-key magit-mode-map (kbd "M-1") 'delete-other-windows)      ; was magit-show-level-1
     (define-key magit-mode-map (kbd "<tab>") 'magit-section-toggle)    ; was smart-tab
     (define-key magit-status-mode-map (kbd "M-K") 'magit-quit-session)
     ))
