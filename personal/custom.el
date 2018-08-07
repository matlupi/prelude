(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command-style
   (quote
    (("" "%(PDF)%(latex) %(file-line-error) %(extraopts) %S%(PDFout)"))))
 '(custom-safe-themes
   (quote
    ("aa87469691932ff791f966bffb885ecd97ebfa4dc4d42e479f3819ac4a3fbcaf" "75c0b9f9f90d95ac03f8647c75a91ec68437c12ff598e2abb22418cd4b255af0" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "6df30cfb75df80e5808ac1557d5cc728746c8dbc9bc726de35b15180fa6e0ad9" "c4465c56ee0cac519dd6ab6249c7fd5bb2c7f7f78ba2875d28a50d3c20a59473" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(flycheck-gcc-language-standard "c++11")
 '(global-linum-mode t)
 ;'(prelude-require-package 'tango)
 ;'(prelude-theme (quote tango-plus))
 '(prelude-theme (quote tango-dard))
 '(safe-local-variable-values
   (quote
    ((TeX-command-extra-options \`
                                (\` -enable-write18))
     (TeX-command-extra-options . "-enable-write18"))))
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
-- Title      : <filename>
-- Project    : <project>
-------------------------------------------------------------------------------
-- File       : <filename>
-- Author     : Matteo Lupi <matteo.lupi@cern.ch>
-- Company    : CERN/Goethe Universitaet Frankfurt am Main
-- Created    : <date>
-- Last update: <date>
-- Platform   : <platform>
-- Target     : Kintex Ultrascale
-- Standard   : <standard>
-------------------------------------------------------------------------------
-- Description: <description string>
-------------------------------------------------------------------------------
<copyright>
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- <date>  1.0      ML	Created
-------------------------------------------------------------------------------

<cursor>
")
 '(vhdl-platform-spec "CERN OS7, Xilinx Vivado 2017.4")
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
