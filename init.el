;'(setq mac-option-modifier 'meta)
;;; init.el --- Prelude's configuration entry point.
;;
;; Copyright (c) 2011-2016 Bozhidar Batsov
;;
;; Author: Bozhidar Batsov <bozhidar@batsov.com>
;; URL: http://batsov.com/prelude
;; Version: 1.0.0
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:
;; This file simply sets up the default load path and requires
;; the various modules defined within Emacs Prelude.

;;; License:

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:
(defvar current-user
      (getenv
       (if (equal system-type 'windows-nt) "USERNAME" "USER")))

(message "Prelude is powering up... Be patient, Master %s!" current-user)

(when (version< emacs-version "24.4")
  (error "Prelude requires at least GNU Emacs 24.4, but you're running %s" emacs-version))

;; Always load newest byte code
(setq load-prefer-newer t)

(defvar prelude-dir (file-name-directory load-file-name)
  "The root dir of the Emacs Prelude distribution.")
(defvar prelude-core-dir (expand-file-name "core" prelude-dir)
  "The home of Prelude's core functionality.")
(defvar prelude-modules-dir (expand-file-name  "modules" prelude-dir)
  "This directory houses all of the built-in Prelude modules.")
(defvar prelude-personal-dir (expand-file-name "personal" prelude-dir)
  "This directory is for your personal configuration.

Users of Emacs Prelude are encouraged to keep their personal configuration
changes in this directory.  All Emacs Lisp files there are loaded automatically
by Prelude.")
(defvar prelude-personal-preload-dir (expand-file-name "preload" prelude-personal-dir)
  "This directory is for your personal configuration, that you want loaded before Prelude.")
(defvar prelude-vendor-dir (expand-file-name "vendor" prelude-dir)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")
(defvar prelude-savefile-dir (expand-file-name "savefile" prelude-dir)
  "This folder stores all the automatically generated save/history-files.")
(defvar prelude-modules-file (expand-file-name "prelude-modules.el" prelude-dir)
  "This files contains a list of modules that will be loaded by Prelude.")

(unless (file-exists-p prelude-savefile-dir)
  (make-directory prelude-savefile-dir))

(defun prelude-add-subfolders-to-load-path (parent-dir)
 "Add all level PARENT-DIR subdirs to the `load-path'."
 (dolist (f (directory-files parent-dir))
   (let ((name (expand-file-name f parent-dir)))
     (when (and (file-directory-p name)
                (not (string-prefix-p "." f)))
       (add-to-list 'load-path name)
       (prelude-add-subfolders-to-load-path name)))))

;; add Prelude's directories to Emacs's `load-path'
(add-to-list 'load-path prelude-core-dir)
(add-to-list 'load-path prelude-modules-dir)
(add-to-list 'load-path prelude-vendor-dir)
(prelude-add-subfolders-to-load-path prelude-vendor-dir)

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; preload the personal settings from `prelude-personal-preload-dir'
(when (file-exists-p prelude-personal-preload-dir)
  (message "Loading personal configuration files in %s..." prelude-personal-preload-dir)
  (mapc 'load (directory-files prelude-personal-preload-dir 't "^[^#].*el$")))

(message "Loading Prelude's core...")

;; the core stuff
(require 'prelude-packages)
(require 'prelude-custom)  ;; Needs to be loaded before core, editor and ui
(require 'prelude-ui)
(require 'prelude-core)
(require 'prelude-mode)
(require 'prelude-editor)
(require 'prelude-global-keybindings)

;; OSX specific settings
(when (eq system-type 'darwin)
  (require 'prelude-osx))

(message "Loading Prelude's modules...")

;; the modules
(if (file-exists-p prelude-modules-file)
    (load prelude-modules-file)
  (message "Missing modules file %s" prelude-modules-file)
  (message "You can get started by copying the bundled example file"))

;; config changes made through the customize UI will be store here
(setq custom-file (expand-file-name "custom.el" prelude-personal-dir))

;; load the personal settings (this includes `custom-file')
(when (file-exists-p prelude-personal-dir)
  (message "Loading personal configuration files in %s..." prelude-personal-dir)
  (mapc 'load (directory-files prelude-personal-dir 't "^[^#].*el$")))

(message "Prelude is ready to do thy bidding, Master %s!" current-user)

(prelude-eval-after-init
 ;; greet the use with some useful tip
 (run-at-time 5 nil 'prelude-tip-of-the-day))

;; enables hunspell for ispell
;;(on macos https://joelkuiper.eu/spellcheck_emacs, http://apple.stackexchange.com/questions/97811/where-are-the-system-spellchecking-dictionaries
;;brew install hunspell
;;cd /Library
;;sudo mkdir Spelling
;;cd Spelling
;;)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (when (executable-find "hunspell")                                                                   ;;
;;   (setq-default ispell-program-name "hunspell")                                                      ;;
;;   (setq ispell-really-hunspell t))                                                                   ;;
;;                                                                                                      ;;
;; (setq ispell-program-name "hunspell")                                                                ;;
;; ;; below two lines reset the the hunspell to it STOPS querying locale!                               ;;
;; (setq ispell-local-dictionary "en_GB") ; "en_US" is key to lookup in `ispell-local-dictionary-alist` ;;
;; (setq ispell-local-dictionary-alist                                                                  ;;
;;       '(("en_GB" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_GB") nil utf-8)))                  ;;
;;                                                                                                      ;;
;; (setenv "DICTIONARY" "en_GB")                                                                        ;;
;; (getenv "LANG")                                                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; if (aspell installed) { use aspell}
;; else if (hunspell installed) { use hunspell }
;; whatever spell checker I use, I always use English dictionary
;; I prefer use aspell because:
;; 1. aspell is older
;; 2. looks Kevin Atkinson still get some road map for aspell:
;; @see http://lists.gnu.org/archive/html/aspell-announce/2011-09/msg00000.html
(defun flyspell-detect-ispell-args (&optional run-together)
  "if RUN-TOGETHER is true, spell check the CamelCase words."
  (let (args)
    (cond
     ((string-match  "aspell$" ispell-program-name)
      ;; Force the English dictionary for aspell
      ;; Support Camel Case spelling check (tested with aspell 0.6)
      (setq args (list "--sug-mode=ultra" "--lang=en_GB"))
      (if run-together
          (setq args (append args '("--run-together" "--run-together-limit=5" "--run-together-min=2")))))
     ((string-match "hunspell$" ispell-program-name)
      ;; Force the English dictionary for hunspell
      (setq args "-d en_GB")))
    args))

(cond
 ((executable-find "aspell")
  ;; you may also need `ispell-extra-args'
  (setq ispell-program-name "aspell"))
; ((executable-find "hunspell")
;  (setq ispell-program-name "hunspell")

  ;; Please note that `ispell-local-dictionary` itself will be passed to hunspell cli with "-d"
  ;; it's also used as the key to lookup ispell-local-dictionary-alist
  ;; if we use different dictionary
  (setq ispell-local-dictionary "en_GB")
  (setq ispell-local-dictionary-alist
        '(("en_GB" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_GB") nil utf-8))))
 ;((setq ispell-program-name nil))

;; ispell-cmd-args is useless, it's the list of *extra* arguments we will append to the ispell process when "ispell-word" is called.
;; ispell-extra-args is the command arguments which will *always* be used when start ispell process
;; Please note when you use hunspell, ispell-extra-args will NOT be used.
;; Hack ispell-local-dictionary-alist instead.
(setq-default ispell-extra-args (flyspell-detect-ispell-args t))
;; (setq ispell-cmd-args (flyspell-detect-ispell-args))
(defadvice ispell-word (around my-ispell-word activate)
  (let ((old-ispell-extra-args ispell-extra-args))
    (ispell-kill-ispell t)
    (setq ispell-extra-args (flyspell-detect-ispell-args))
    ad-do-it
    (setq ispell-extra-args old-ispell-extra-args)
    (ispell-kill-ispell t)
    ))

(defadvice flyspell-auto-correct-word (around my-flyspell-auto-correct-word activate)
  (let ((old-ispell-extra-args ispell-extra-args))
    (ispell-kill-ispell t)
    ;; use emacs original arguments
    (setq ispell-extra-args (flyspell-detect-ispell-args))
    ad-do-it
    ;; restore our own ispell arguments
    (setq ispell-extra-args old-ispell-extra-args)
    (ispell-kill-ispell t)
    ))

(defun text-mode-hook-setup ()
  ;; Turn off RUN-TOGETHER option when spell check text-mode
  (setq-local ispell-extra-args (flyspell-detect-ispell-args)))
(add-hook 'text-mode-hook 'text-mode-hook-setup)



;;; init.el ends here
