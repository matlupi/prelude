(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-gcc-language-standard "c++11")
 '(global-linum-mode t)
 '(package-selected-packages
   (quote
-    (puppet-mode zop-to-char zenburn-theme yaml-mode writegood-mode which-key volatile-highlights undo-tree tangotango-theme solarized-theme smex smartrep smartparens smart-mode-line rainbow-mode rainbow-delimiters py-autopep8 project-explorer ov operate-on-number move-text monokai-theme markdown-mode magit langtool key-chord json-mode js2-mode imenu-anywhere ido-ubiquitous helm-projectile helm-descbinds helm-ag guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck flx-ido expand-region emojify elpy elisp-slime-nav ein easy-kill discover-my-major diminish diff-hl define-word csv-mode crux company-auctex company-anaconda cdlatex caml browse-kill-ring beacon base16-theme auctex-latexmk anzu ace-window)))
- ;; These following packets were removed by bbastov in newer versions evaluate if to remove them as well
-'(package-selected-packages
-  (quote
    (rtags pdf-tools org-pomodoro org-gnome leuven-theme helm-swoop cpputils-cmake cmake-mode clang-format blackboard-theme auto-complete-clang jedi super-save ido-completing-read+ hl-todo helm-ag exec-path-from-shell editorconfig)))
'(package-selected-packages
  (quote
   (dockerfile-mode auto-complete-auctex)))
 '(prelude-theme (quote tango-dark))
 '(safe-local-variable-values
   (quote
    ((TeX-command-extra-options \`
                                (\` -enable-write18))
     (eval verilog-read-includes))))
 '(show-paren-mode t)
 '(user-mail-address "matteo.lupi@cern.ch")
 '(vhdl-clock-edge-condition (quote function))
 '(vhdl-clock-name "")
 '(vhdl-company-name "CERN European Organization for Nuclear Research")
 '(vhdl-copyright-string
   "-------------------------------------------------------------------------------
-- Copyright (c) <year>
")
 '(vhdl-electric-mode t)
 '(vhdl-file-header
   "-------------------------------------------------------------------------------
-- Title      : <title string>
-- Project    : <project>
-------------------------------------------------------------------------------
-- File       : <filename>
-- Author     : Matteo Lupi <matteo.lupi@cern.ch>
-- Company    : <company>
-- Company    : Goethe Universitaet Frankfurt am Main
-- Created    : <date>
-- Last update: <date>
-- Platform   : <platform>
-- Target     : Kintex 7
-- Standard   : <standard>
<projectdesc>-------------------------------------------------------------------------------
-- Description: <description string>
<copyright>-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- <date>  1.0      ML	Created
-------------------------------------------------------------------------------

<cursor>
")
 '(vhdl-platform-spec "CERN OS7, Xilinx Vivado 2016.4")
 '(vhdl-reset-active-high t)
 '(vhdl-reset-kind (quote sync))
 '(vhdl-reset-name "")
 '(vhdl-stutter-mode t)
 '(vhdl-upper-case-enum-values t)
 '(vhdl-upper-case-keywords nil)
 '(vhdl-use-direct-instantiation (quote always))
 '(whitespace-line-column 120))
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

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
