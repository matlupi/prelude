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
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-inst-param-value t)
 '(verilog-auto-inst-vector nil)
 '(verilog-auto-lineup (quote all))
 '(verilog-auto-newline nil)
 '(verilog-auto-save-policy nil)
 '(verilog-auto-template-warn-unused t)
 '(verilog-case-indent 2)
 '(verilog-cexp-indent 2)
 '(verilog-highlight-grouping-keywords t)
 '(verilog-highlight-modules t)
 '(verilog-indent-level 2)
 '(verilog-indent-level-behavioral 2)
 '(verilog-indent-level-declaration 2)
 '(verilog-indent-level-module 2)
 '(verilog-tab-to-comment t))
