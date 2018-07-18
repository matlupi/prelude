;;; https://github.com/mhayashi1120/Emacs-langtool

(setq langtool-language-tool-jar "/opt/LanguageTool-4.1/languagetool-commandline.jar")
(require 'langtool)

;;; binds hotkeys
(global-set-key "\C-x4w" 'langtool-check)
(global-set-key "\C-x4W" 'langtool-check-done)
(global-set-key "\C-x4l" 'langtool-switch-default-language)
(global-set-key "\C-x44" 'langtool-show-message-at-point)
(global-set-key "\C-x4c" 'langtool-correct-buffer)

;;;set default language for checking toolx
(setq langtool-default-language "en-GB")

;;; Set mothertongue to italian
(setq langtool-mother-tongue "it")
