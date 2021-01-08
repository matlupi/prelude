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
