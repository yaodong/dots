;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

(package! jenkinsfile-mode)
(package! verb)
(package! catppuccin-theme)
(package! eglot-booster
  :recipe (:host github
           :repo "jdtsmith/eglot-booster"))
(package! copilot
  :recipe (:host github :repo "copilot-emacs/copilot.el" :files ("*.el")))
