;;(define-key ctl-x-4-map (kbd "t") 'crux-transpose-windows)

(defun my-c-initialization-hook ()
  (define-key c-mode-base-map (kbd "C-c v") 'ff-find-other-file)
  (define-key c-mode-base-map (kbd "C-c .") nil))
(add-hook 'c-initialization-hook 'my-c-initialization-hook)
