;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Yaodong Zhao"
      user-mail-address "emacs@yaodong.dev")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
(setq doom-font (font-spec :family "Jetbrains Mono" :size 13 :slant 'normal :weight 'normal)
      doom-font-increment 1)

;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/"
      org-journal-file-format "%Y-%m-%d.org"
      org-journal-time-prefix "** TODO ")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! :leader
      :desc "Open code-runner.org"
      "o c"
      #'(lambda () (interactive) (find-file (concat org-directory "code-runner.org"))))

(map! :leader
      :desc "Open scratch.org"
      "o s"
      #'(lambda () (interactive) (find-file (concat org-directory "scratch.org"))))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(use-package! web-mode
  :config
  (setq indent-tabs-mode nil
        web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2)
  )

;; Increase and decrease font size
(map! :n "C-="    #'doom/reset-font-size
      ;; Buffer-local font resizing
      :n "C-+"    #'text-scale-increase
      :n "C--"    #'text-scale-decrease)

;; Navigating through emacs, across buffer.
(setq avy-all-windows t)

;; Copilot
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

;; Treemacs
;; enable follow up mode
(use-package! treemacs
  :config
  (treemacs-follow-mode 1))

;; Ruby
(add-hook 'ruby-mode-hook
          (lambda ()
            (flycheck-select-checker 'ruby-standard)))

;; Tabs
(map! :n "s-}" #'centaur-tabs-forward
      :n "s-{" #'centaur-tabs-backward)

;; disable tab-bar
(tab-bar-mode -1)

;; hidde tabs
(after! centaur-tabs
  (dolist (item '("*Message" "*Warnings" "*copilot" "*Async" "*Native" "*scratch" "*apheleia" "*lsp" "*compilation"))
    (add-to-list 'centaur-tabs-excluded-prefixes item)))

;; web-mode
(use-package! web-mode
  :custom
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2))

;; (define-derived-mode erb-mode web-mode "ERB"
;;   "Major mode for editing ERB (Embedded Ruby) templates.")
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . erb-mode))

(use-package! apheleia
  :config
  ;; use rubocop for ruby
  (add-to-list 'apheleia-mode-alist
               '(ruby-mode rubocop)))

;; config.el ends here
