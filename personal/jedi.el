;; Installs Jedi (http://tkf.github.io/emacs-jedi/latest/)

(prelude-require-packages
 '(jedi)
 )

;; configures jedi
(add-hook 'python-mode-hook 'jedi:setup)
;; condigured jedi to autocomplete on .
(setq jedi:complete-on-dot t)                 ; optional
