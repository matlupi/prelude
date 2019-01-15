(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (d-mode tangotango-theme solarized-theme rtags py-autopep8 project-explorer pdf-tools org-projectile org-pomodoro org-gnome monokai-theme leuven-theme helm-swoop emojify elpy ein define-word cpputils-cmake cmake-mode clang-format blackboard-theme base16-theme auto-complete-clang langtool jedi auctex-latexmk zop-to-char zenburn-theme writegood-mode which-key volatile-highlights undo-tree super-save smex smartrep smartparens smart-mode-line rainbow-mode rainbow-delimiters ov operate-on-number move-text magit key-chord imenu-anywhere ido-completing-read+ hl-todo helm-projectile helm-descbinds helm-ag guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck flx-ido expand-region exec-path-from-shell elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux company-auctex company-anaconda cdlatex browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "SeaGreen4")))))

;; line number mode is on by default
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(add-to-list 'auto-mode-alist '("\\.xdc\\'". tcl-mode))
(add-to-list 'auto-mode-alist '("\\.ino\\'". c-mode))
(add-to-list 'auto-mode-alist '("\\.el\\'". lisp-mode))

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
