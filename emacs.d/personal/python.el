;; Configure flymake for Python

(setq pylint-rc nil)
(setq pycheck "epylint")

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name)))
           (pylint-rc-arg (if pylint-rc
                              (concat "--rcfile=" pylint-rc)
                              nil)))
      (list pycheck (if pylint-rc-arg (list local-file pylint-rc-arg) (list local-file)))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Set as a minor mode for Python
(add-hook 'python-mode-hook '(lambda () (flymake-mode)))

;; Configure to wait a bit longer after edits before starting
(setq-default flymake-no-changes-timeout '1)

;; Keymaps to navigate to the errors
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cn" 'flymake-goto-next-error)))
(add-hook 'python-mode-hook '(lambda () (define-key python-mode-map "\C-cp" 'flymake-goto-prev-error)))


(defun flymake-show-error ()
  "Show the flymake error message at point."
  (interactive)
  (let ((error-message (flymake-error-at-point)))
    (when error-message
      (message "%s" error-message))))

(defun flymake-error-at-point ()
  "Return the flymake error at point, or nil if there is none."
  (when (boundp 'flymake-err-info)
    (let* ((lineno (line-number-at-pos))
           (err-info (car (flymake-find-err-info flymake-err-info
                                                 lineno))))
      (when err-info
        (mapconcat #'flymake-ler-text
                   err-info
                   ", "))))
  (when (and (fboundp 'flymake-diagnostics) (fboundp 'flymake-diagnostic-text))
    (mapconcat #'flymake-diagnostic-text (flymake-diagnostics (point)) "\n")
    )
  )

(defadvice flymake-goto-next-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (flymake-show-error))

(defadvice flymake-goto-prev-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (flymake-show-error))
