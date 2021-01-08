;;; Verilog mode configuration file for verilog mode-line

;;; https://www.reddit.com/r/emacs/comments/4cjt2z/about_verilogmode_i_need_someone_help/
(with-eval-after-load 'verilog-mode
  (defvar modi/verilog-eda-vendor "cadence" ; "xyz"
    "EDA vendor tools to use for verilog/SV compilation, simulation, etc.")

  (defvar modi/verilog-cadence-linter '("irun" "-hal" "-l hal.log" "+incdir+../../../source/rtl/*/includes/")
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

(setq vlog-skel-header-string "\
//^File Header -----------------------------------------< Powered By Emacs >--
// Copyright (C) %<time %Y> %<company>
// All rights reserved
// ---------------------------------------------------------------------------
// $Id$
// FILE NAME   : %<filename>
// MODULE NAME : %<modulename>
// AUTHOR      : %<author>
// ---------------------------------------------------------------------------
// [RELEASE HISTORY]                               Last Modified : %<time %Y-%m-%d>
// VERSION  DATE        AUTHOR      DESCRIPTION
// 1.0%<align>%<time %y-%m-%d>%<align>%<author>%<align>Original
// ---------------------------------------------------------------------------
// [DESCRIPTION]
// %<_>
// ---------------------------------------------------------------------------
// [SUBMODULE LIST]
// [ N o n e ]
// ---------------------------------------------------------------------------
// [PARAMETERS]
// PARAM_NAME   RANGE               DEFAULT         DESCRIPTION
// ----------   -----               -------         -----------
// [ N o n e ]
//$File Header -----------------------------------------< Powered By Emacs >--\n")

(setq vlog-skel-user-name    "Matteo Lupi <matteo.lupi@cern.ch>"
            vlog-skel-company-name "CERN")

(custom-set-variables
 '(verilog-align-ifelse t)
(define-skeleton verilog-sk-header-tmpl
  "Insert a comment block containing the module title, author, etc."
  "[Description]: "
  "// ----------------------------------------------------------------------------"
  "\n// Title         : " (buffer-name)
  "\n// Project       : RU_mainFPGA                                                 "
  "\n//-----------------------------------------------------------------------------"
  "\n// File          : " (buffer-name)
  "\n// Author        : Matteo Lupi <matteo.lupi@cern.ch>                           "
  "\n// Created       : " (current-time-string)
  "\n// Last modified : " (current-time-string)
  "\n//-----------------------------------------------------------------------------"
  "\n// Description :                                                               "
  "\n// " str
  "\n//-----------------------------------------------------------------------------"
  "\n// Status:                                                                     "
  "\n// Development, might not work yet!                                            "
  "\n//-----------------------------------------------------------------------------"
  "\n// Copyright (c) %<time %Y> by CERN This model is the confidential and         "
  "\n// proprietary property of CERN and the possession or use of this              "
  "\n// file requires a written license from CERN.                                  "
  "\n//-----------------------------------------------------------------------------"
  "\n// Modification history :                                                      "
  "\n// " (current-time-string)
  " ML   Created"
  "\n// ----------------------------------------------------------------------------"
  "\n")

(custom-set-variables
 '(verilog-align-ifelse nil)
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-inst-param-value t)
 '(verilog-auto-inst-vector nil)
 '(verilog-auto-lineup (quote all))
 '(verilog-auto-lineup t)
 '(verilog-auto-newline nil)
 '(verilog-auto-template-warn-unused t)
 '(verilog-case-indent 2)
 '(verilog-cexp-indent 2)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-highlight-modules t)
 '(verilog-indent-level 2)
 '(verilog-indent-level-behavioral 2)
 '(verilog-indent-level-declaration 2)
 '(verilog-indent-level-module 2)
 '(verilog-indent-level-directive 0)
 '(verilog-tab-to-comment t)
 '(verilog-auto-endcomments t)
 '(verilog-minimum-comment-distance 0)
 '(verilog-indent-begin-after-if nil)
 )

;;; moved from custom on pcphaiddt001
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
