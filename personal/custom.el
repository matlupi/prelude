(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote luatex))
 '(custom-safe-themes
   (quote
    ("aa87469691932ff791f966bffb885ecd97ebfa4dc4d42e479f3819ac4a3fbcaf" "75c0b9f9f90d95ac03f8647c75a91ec68437c12ff598e2abb22418cd4b255af0" "5999e12c8070b9090a2a1bbcd02ec28906e150bb2cdce5ace4f965c76cf30476" "6df30cfb75df80e5808ac1557d5cc728746c8dbc9bc726de35b15180fa6e0ad9" "c4465c56ee0cac519dd6ab6249c7fd5bb2c7f7f78ba2875d28a50d3c20a59473" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(flycheck-gcc-language-standard "c++11")
 '(global-linum-mode t)
 '(prelude-theme (quote tango-dark))
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


(add-to-list 'auto-mode-alist '("\\.xdc\\'". tcl-mode))
(add-to-list 'auto-mode-alist '("\\.il\\'". lisp-mode))
;;(add-to-list 'auto-mode-alist '("\\.pkg\\'". vhdl-mode))

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)


;;; Verilog mode configuration file for verilog mode-line

;;; https://www.reddit.com/r/emacs/comments/4cjt2z/about_verilogmode_i_need_someone_help/
(with-eval-after-load 'verilog-mode
  (defvar modi/verilog-eda-vendor "cadence" ; "xyz"
    "EDA vendor tools to use for verilog/SV compilation, simulation, etc.")

  (defvar modi/verilog-cadence-linter '("irun" "-hal" "-l hal.log")
    "Verilog/SV linting command using Cadence.")
  (defvar modi/verilog-cadence-compiler '("irun" "-compile")
    "Verilog/SV compilation command using Cadence.")
  (defvar modi/verilog-cadence-simulator '("irun" "-access" "rwc")
    "Verilog/SV simulation command using Cadence.")

  (defvar modi/verilog-xyz-linter '("these" "need" "to" "be" "defined")
    "Verilog/SV linting command using Xyz.")
  (defvar modi/verilog-xyz-compiler '("these" "need" "to" "be" "defined")
    "Verilog/SV compilation command using Xyz.")
  (defvar modi/verilog-xyz-simulator '("these" "need" "to" "be" "defined")
    "Verilog/SV simulation command using Xyz.")

  (setq verilog-tool 'verilog-linter)
  ;; (setq verilog-tool 'verilog-compiler)
  ;; (setq verilog-tool 'verilog-simulator)

  (defun modi/verilog-tool-setup ()
    "Set up for running verilog/SV compilation, simulation, etc.
This function needs to be run in `verilog-mode-hook'."
    (let* ((vendor-linter (symbol-value (intern (concat "modi/verilog-"
                                                        modi/verilog-eda-vendor
                                                        "-linter"))))
           (cmd-linter (mapconcat 'identity vendor-linter " "))
           (vendor-compiler (symbol-value (intern (concat "modi/verilog-"
                                                          modi/verilog-eda-vendor
                                                          "-compiler"))))
           (cmd-compiler (mapconcat 'identity vendor-compiler " "))
           (vendor-simulator (symbol-value (intern (concat "modi/verilog-"
                                                           modi/verilog-eda-vendor
                                                           "-simulator"))))
           (cmd-simulator (mapconcat 'identity vendor-simulator " ")))
      (when (executable-find (car vendor-linter))
        (setq verilog-linter cmd-linter))
      (when (executable-find (car vendor-compiler))
        (setq verilog-compiler cmd-compiler))
      (when (executable-find (car vendor-simulator))
        (setq verilog-simulator cmd-simulator)))
    (verilog-set-compile-command))
  (add-hook 'verilog-mode-hook #'modi/verilog-tool-setup))

;; ;;; redefine header for verilog-sk-header
;; (define-skeleton my/verilog-sk-header-tmpl
;;   "Insert a comment block containing the module title, author, etc."
;; ;; //^File Header -----------------------------------------< Powered By Emacs >--
;; ;; // Copyright (C) %<time %Y> %<company>
;; ;; // All rights reserved
;; ;; // ---------------------------------------------------------------------------
;; ;; // $Id$
;; ;; // FILE NAME   : %<filename>
;; ;; // MODULE NAME : %<modulename>
;; ;; // AUTHOR      : %<author>
;; ;; // ---------------------------------------------------------------------------
;; ;; // [RELEASE HISTORY]                               Last Modified : %<time %Y-%m-%d>
;; ;; // VERSION  DATE        AUTHOR      DESCRIPTION
;; ;; // 1.0%<align>%<time %y-%m-%d>%<align>%<author>%<align>Original
;; ;; // ---------------------------------------------------------------------------
;; ;; // [DESCRIPTION]
;; ;; // %<_>
;; ;; // ---------------------------------------------------------------------------
;; ;; // [SUBMODULE LIST]
;; ;; // [ N o n e ]
;; ;; // ---------------------------------------------------------------------------
;; ;; // [PARAMETERS]
;; ;; // PARAM_NAME   RANGE               DEFAULT         DESCRIPTION
;; ;; // ----------   -----               -------         -----------
;; ;; // [ N o n e ]
;; ;; //$File Header -----------------------------------------< Powered By Emacs >--\n
;;   "\n")


;; (defun verilog-sk-header ()
;;   "Insert a descriptive header at the top of the file.
;; See also `verilog-header' for an alternative format."
;;   (interactive "*")
;;   (save-excursion
;;     (goto-char (point-min))
;;     (my/verilog-sk-header-tmpl)))

;; (defun verilog-sk-header "\
;; //^File Header -----------------------------------------< Powered By Emacs >--
;; // Copyright (C) %<time %Y> %<company>
;; // All rights reserved
;; // ---------------------------------------------------------------------------
;; // $Id$
;; // FILE NAME   : %<filename>
;; // MODULE NAME : %<modulename>
;; // AUTHOR      : %<author>
;; // ---------------------------------------------------------------------------
;; // [RELEASE HISTORY]                               Last Modified : %<time %Y-%m-%d>
;; // VERSION  DATE        AUTHOR      DESCRIPTION
;; // 1.0%<align>%<time %y-%m-%d>%<align>%<author>%<align>Original
;; // ---------------------------------------------------------------------------
;; // [DESCRIPTION]
;; // %<_>
;; // ---------------------------------------------------------------------------
;; // [SUBMODULE LIST]
;; // [ N o n e ]
;; // ---------------------------------------------------------------------------
;; // [PARAMETERS]
;; // PARAM_NAME   RANGE               DEFAULT         DESCRIPTION
;; // ----------   -----               -------         -----------
;; // [ N o n e ]
;; //$File Header -----------------------------------------< Powered By Emacs >--\n")

(setq vlog-skel-user-name    "Matteo Lupi <matteo.lupi@cern.ch>"
            vlog-skel-company-name "CERN")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; verilog mode
(autoload 'verilog-mode "verilog-mode" "Verilog Mode" t)
(require 'verilog-mode)
(setq auto-mode-alist (cons '("\\.verilog?$" . verilog-mode) auto-mode-alist))

(define-skeleton verilog-sk-always
  "Insert always block.  Uses the minibuffer to prompt
for sensitivity list."
  ()
  > "always @ (" _ ") begin" \n \n
  > (- verilog-indent-level-behavioral) "end")

(define-skeleton verilog-sk-if
  "Insert a skeleton if statement."
  > "if (" _  ")" " begin" \n \n
  > (- verilog-indent-level-behavioral) "end" \n )

(define-skeleton verilog-sk-else-if
  "Insert a skeleton else if statement."
  > (verilog-indent-line) "else if (" _ ") " " begin" \n \n
  > "end" \n)

(define-skeleton verilog-sk-case
  "Build skeleton case statement, prompting for the selector expression,
and the case items."
  "[selector expression]: "
  > "case (" _ ")" \n \n
  > "endcase" \n)

(define-skeleton verilog-sk-casex
  "Build skeleton casex statement, prompting for the selector expression,
and the case items."
  "[selector expression]: "
  > "casex (" _ ") " \n \n
  > (- verilog-case-indent) "endcase" \n)

(define-skeleton verilog-sk-casez
    "Build skeleton casez statement, prompting for the selector expression,
and the case items."
  "[selector expression]: "
  > "casez (" _ ") " \n
  >  (- verilog-case-indent) "endcase" \n)

(define-skeleton verilog-sk-for
  "Insert a skeleton while loop statement."
  ()
  > "for (" _ "; ; ) begin" \n \n
  >  (- verilog-indent-level-behavioral) "end" \n)

(define-skeleton verilog-sk-repeat
  "Insert a skeleton repeat loop statement."
  ()
  > "repeat ("  _  ") begin" \n \n
  > (- verilog-indent-level-behavioral) "end" \n)

(define-skeleton verilog-sk-while
  "Insert a skeleton while loop statement."
  ()
  > "while (" _ ") begin" \n \n
  > (- verilog-indent-level-behavioral) "end")

(define-skeleton verilog-sk-module
  "Insert a module definition."
  ()
  > "module " _ " (" \n
  > ");" \n
  > "endmodule" \n)

(define-abbrev verilog-mode-abbrev-table "input" nil)
(define-abbrev verilog-mode-abbrev-table "assign" nil)
(define-abbrev verilog-mode-abbrev-table "input" nil)
(define-abbrev verilog-mode-abbrev-table "output" nil)
(define-abbrev verilog-mode-abbrev-table "inout" nil)
(define-abbrev verilog-mode-abbrev-table "wire" nil)
(define-abbrev verilog-mode-abbrev-table "reg" nil)

;; ML DISABLED verilator as linter
;; (setq-default verilog-linter "verilator --lint-only")
;; (defun my-verilog-mode-hook()
;;   (setq verilog-indent-level 4
;;         verilog-indent-level-module 0
;;         verilog-indent-level-declaration 0
;;         verilog-indent-level-behavioral 4
;;         verilog-indent-level-directive 4
;;         verilog-case-indent 0
;;         verilog-cexp-indent 4
;;         verilog-tab-always-indent t
;;         verilog-indent-lists nil
;;         verilog-indent-begin-after-if nil
;;         verilog-minimum-comment-distance 0
;;         verilog-auto-endcomments nil
;;         verilog-auto-lineup 'declarations)
;;   (setq show-trailing-whitespace t)
;;   (trail-line-mode 0)
;;   (define-key verilog-mode-map "\C-c\C-t" 'trail-toggle)
;; )
;; (add-hook 'verilog-mode-hook 'my-verilog-mode-hook)
