(projectile-global-mode)

(setq projectile-mode-line-function '(lambda () (format " Proj[%s]" (projectile-project-name))))

(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
