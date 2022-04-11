;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
;; Sarasa Mono SC Nerd
;; UbuntuMono NF
;; InconsolataLGC NF
;; VictorMono NF
;; Anonymice NF
;; Azeret Mono
;; mononoki NF
;; Red Hat Mono
(setq cur-font "VictorMono NF")
(setq doom-font (font-spec :family cur-font :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family cur-font :size 17)
      doom-big-font cur-font)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq package-build-path "~/.emacs.d/.local/straight/build-27.2/")
;; (add-to-list 'custom-theme-load-path (concat package-build-path "melancholy-theme"))
;; (add-to-list 'custom-theme-load-path (concat package-build-path "alect-themes"))
(setq doom-theme 'humanoid-dark)

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
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! "C-/" #'comment-line)

(defun set-input-method-to-rime ()
  (interactive)
  (if (string-equal "rime" default-input-method)
      (toggle-input-method)
    (set-input-method "rime")))

(map! "C-;" #'set-input-method-to-rime)

(map! :leader
      (:prefix-map ("e" . "S-expression operations")
       :desc "slurp-forward" "s" #'sp-forward-slurp-sexp
       :desc "slurp-backward" "S" #'sp-backward-slurp-sexp
       :desc "move the first sexp out" "b" #'sp-backward-barf-sexp
       :desc "move the last sexp out" "B" #'sp-forward-barf-sexp)
      (:prefix-map ("j" . "Easy motion movement")
       :desc "jump goto line above" "l" #'avy-goto-line-above
       :desc "jump goto line below" "L" #'avy-goto-line-below
       :desc "goto char" "j" #'evil-avy-goto-char
       :desc "goto word" "w" #'evil-avy-goto-word-0
       )
      )

;;;;;;;;;; shell ;;;;;;;;;;;;;;
(defun sudo-shell-command (command)
  (interactive "xShell command (root): ")
  (shell-command (concat "echo " (shell-quote-argument (read-passwd "Password? "))
                         (format " | sudo -S %s" command))))


(use-package! deft
  :commands deft
  :init
  (setq deft-default-extension "org"))

(use-package! rime
  :custom
  (rime-show-candidate 'posframe)
  (default-input-method "rime"))

;;; config org ref


(after! nov
  (defun my-nov-font-setup ()
    (face-remap-add-relative 'variable-pitch :family "Liberation Serif"
                             :height 1.0))
  (add-hook 'nov-mode-hook 'my-nov-font-setup)
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

  (setq nov-text-width t)
  (setq visual-fill-column-center-text t)
  (add-hook 'nov-mode-hook 'visual-line-mode)
  (add-hook 'nov-mode-hook 'visual-fill-column-mode)

  (require 'justify-kp)
  (setq nov-text-width t)

  (defun my-nov-window-configuration-change-hook ()
    (my-nov-post-html-render-hook)
    (remove-hook 'window-configuration-change-hook
                 'my-nov-window-configuration-change-hook
                 t))

  (defun my-nov-post-html-render-hook ()
    (if (get-buffer-window)
        (let ((max-width (pj-line-width))
              buffer-read-only)
          (save-excursion
            (goto-char (point-min))
            (while (not (eobp))
              (when (not (looking-at "^[[:space:]]*$"))
                (goto-char (line-end-position))
                (when (> (shr-pixel-column) max-width)
                  (goto-char (line-beginning-position))
                  (pj-justify)))
              (forward-line 1))))
      (add-hook 'window-configuration-change-hook
                'my-nov-window-configuration-change-hook
                nil t)))

  (add-hook 'nov-post-html-render-hook 'my-nov-post-html-render-hook)
  )


;;;;;;;;;;;;;;;;;;;;;; elfeed ;;;;;;;;;;;;;;;;;;;;;
(setq url-queue-timeout 30)

(use-package! ledger-mode
  :init
  (setq ledger-clear-whole-transactions 1)
  :mode "\\.ledger\\'")
;;;;;;;;;;;;;;;;;;;;;; mail config ;;;;;;;;;;;;;;;;;;;;;;

(map! "C-/" #'comment-line)
(map! "C-," #'toggle-input-method)

(defun insert-date-string ()
  (interactive)
  (insert
   (current-time-string)))

(defun insert-file-path (file &optional relativep)
  "Read file name and insert it at point.
With a prefix argument, insert only the non-directory part."
  (interactive "fFile: \nP")
  (when relativep (setq file (file-name-nondirectory file)))
  (insert (replace-regexp-in-string (getenv "HOME") "~" file)))

(map!
 :leader
 (:prefix ("i" . insert)
  :nv
  :desc "Date" "d" #'insert-date-string
  :desc "File path" "P" #'insert-file-path))

;;;;;;;;;;;;; org ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;
(defun insert-now-timestamp()
  "Insert org mode timestamp at point with current date and time."
  (interactive)
  (org-insert-time-stamp (current-time) t))

(use-package! scihub
  :init
  (setq scihub-download-directory "~/Documents/Resources/Papers"
        scihub-open-after-download t
        scihub-fetch-domain 'scihub-fetch-domains-lovescihub))

(use-package! beacon
  :custom
  (beacon-mode t))

(when (equal "work" (getenv "DIST"))
  (use-package! mu4e
    :load-path "/data/app/mu-1.6.10/mu4e/"
    :init
    (setq mu4e-mu-binary "/data/app/mu-1.6.10/mu/mu")
    (setq mu4e-maildir (expand-file-name "/data/mail"))
    (setq mu4e-get-mail-command "true")
    ;; ;; sync
    (setq mu4e-get-mail-command "mbsync cambricon")
    (setq mu4e-change-filenames-when-moving t)
    (setq mu4e-view-prefer-html t)
    (setq mu4e-html2text-command "html2text -utf8 -width 150")
    (setq
     +mu4e-backend 'mbsync
     sendmail-program (executable-find "msmtp")
     send-mail-function #'smtpmail-send-it
     message-sendmail-f-is-evil t
     message-sendmail-extra-arguments '("--read-envelope-from")
     message-send-mail-function #'message-send-mail-with-sendmail)

    ;; these are required for sending email
    (setq smtpmail-default-smtp-server  "mail.cambricon.com")
    (setq smtpmail-smtp-server "mail.cambricon.com")

    (set-email-account!
     "cambricon"
     '((mu4e-trash-folder      . "/cambricon/Trash/")
       (mu4e-refile-folder     . "/cambricon/Inbox/")
       (mu4e-sent-folder       . "/cambricon/sent/")
       (mu4e-drafts-folder     . "/cambricon/drafts/")
       (smtpmail-smtp-user     . "lanhuiying@cambricon.com")
       (user-mail-address      . "lanhuiying@cambricon.com")    ;; only needed for mu < 1.4
       )
     t)

    (setq mu4e-org-contacts-file  "~/Documents/RoamNotes/20220304154932-contacts.org")

    ;;(add-to-list 'mu4e-headers-actions
    ;;             '("org-contact-add" . mu4e-action-add-org-contact) t)
    ;;(add-to-list 'mu4e-view-actions
    ;;             '("org-contact-add" . mu4e-action-add-org-contact) t)
    ;; refile
    (setq mu4e-refile-folder
          (lambda (msg)
            (cond
             ;; message with Jira, goes to jira
             (
              (mu4e-message-contact-field-matches
               msg
               :to
               "lanhuiying@cambricon.com")
              "/cambricon/Jira"
              )
             )
            )
          )

    (map!
     :map mu4e-headers-mode-map
     :desc "org-store-link-and-capture"
     "C-c c"
     #'mu4e-org-store-and-capture)
    )

  (use-package! eaf
    :load-path "~/.doom.d/packages/emacs-application-framework"
    :config
    (require 'eaf-mindmap))
  )

(when (equal "personal" (getenv "DIST"))
  ;;
  (use-package! arduino-mode
    :init
    (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
    (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t))

  ;;; set proxy
  (setenv "http_proxy" "socks5://127.0.0.1:10800")
  (setenv "https_proxy" "socks5://127.0.0.1:10800")
  (setq reftex-default-bibliography '("~/Documents/RoamNotes/bibliography/ref.bib"))

  (defun auii/unset_proxy ()
    (interactive)
    (setenv "http_proxy" "")
    (setenv "https_proxy" ""))

  )



(load! "org.el")
