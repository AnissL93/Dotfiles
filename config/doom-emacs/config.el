;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Huiying Lan"
      user-mail-address "lan_huiying@outlook.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "Sarasa Mono CL" :size 18 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "Hack" :size 15))
;; JetBrains Mono
;; Liberation Mono
;; Hack NF
;; FantasqueSansMono NF
;; SauceCodePro  NF
(setq doom-font (font-spec :family "Liberation Mono" :size 15 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "Hack NF" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'moe-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Projects/Org-files")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! "C-/" #'comment-line)

(map! :leader
      (:prefix-map ("e" . "S-expression operations")
       (:prefix ("s" . "S-expression slurp")
        :desc "slurp-forward" "f" #'sp-forward-slurp-sexp
        :desc "slurp-backward" "b" #'sp-backward-slurp-sexp
        )
       (:prefix ("b" . "barf S-expression")
        :desc "move the first sexp out" "b" #'sp-backward-barf-sexp
        :desc "move the last sexp out" "f" #'sp-forward-barf-sexp
        ))
      (:prefix-map ("j" . "Easy motion movement")
       (:prefix ("l" . "Jump to line")
        :desc "jump goto line above" "b" #'avy-goto-line-above
        :desc "jump goto line below" "f" #'avy-goto-line-below
        )
       :desc "goto char" "j" #'evil-avy-goto-char
       :desc "goto word" "w" #'evil-avy-goto-word-0
       )
      )

;;;;;;;;;; shell ;;;;;;;;;;;;;;
(defun sudo-shell-command (command)
  (interactive "xShell command (root): ")
  (shell-command (concat "echo " (shell-quote-argument (read-passwd "Password? "))
                         (format " | sudo -S %s" command))))


(use-package! org-roam
  :ensure t
  :custom
  (setq org-roam-directory "~/Documents/RoamNotes")
  :config
  (org-roam-setup)
  (map! :leader
        (:prefix ("l" .  "Roam")
         :desc "find node" "f" #'org-roam-node-find
         :desc "insert node" "i" #'org-roam-node-insert
         :desc "open node" "o" #'org-roam-node-open
         )
       )
  )
