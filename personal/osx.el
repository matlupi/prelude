;; remaps meta from ESC to ALT
;'(setq mac-option-modifier 'meta)

;; Emulates mouse 2 event on trackpad for mac (https://emacs.stackexchange.com/questions/20946/generate-mouse-2-event-from-macbook-trackpad)
(define-key key-translation-map (kbd "<s-mouse-1>") (kbd "<mouse-2>"))
