;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;
;;;
(setq user-full-name "huiying.lan"
      user-mail-address "hy.lan@nus.edu.sg")

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
;; B612 Mono
;; Comic Mono
;; CaskaydiaCove NF
;; Consola Mono
;; Jozsika
;; Acevedo (regular only)
;; TT2020Base
;; Office Code Pro
;; Cascadia Mono
;; (setq cur-font "Office Code Pro")
;; (setq cur-font "UbuntuMono ")
;; (setq cur-font "DinaRemaster")
;; (setq cur-font "Cascadia Code")
;; (setq cur-font "Azeret Mono")
;; (setq cur-font "Comic Code Ligatures")
;; (setq cur-font "FuraMono NF")
;; (setq cur-font "JetBrains Mono Nerd Font")
;; (setq cur-font "ProggyVector")
;;
;; (setq cur-font "Drafting Mono ")
;; (setq cur-font "SF Mono")
;; (setq cur-font "Inconsolata Nerd Font")
;; (setq cur-font "UbuntuMono Nerd Font")
;; (setq cur-font "Liga Hack")
;; (setq cur-font "LXGW WenKai Mono")
;; (setq cur-font "FantasqueSansMono Nerd Font")
;; (setq cur-font "OverpassMono Nerd Font")
;; (setq cur-font "InconsolataLGC NF")
;; (setq cur-font "Hasklug Nerd Font")
;; (setq cur-font "Consola Mono")
;; (setq cur-font "Monoid Nerd Font")
;; (setq cur-font "Input Mono")
;; (setq cur-font "Envy Code R")
;; (setq cur-font "LXGW WenKai Mono")
;; (setq cur-font "Ligalex Mono")
;; (setq cur-font "Liga Hack")
;; (setq cur-font "LigaSrc Pro")
;; (setq cur-font "CamingoCode")
;; (setq cur-font "Iosevka Curly")
;; (setq cur-font "Sometype Mono")
;; (setq cur-font "Verily Serif Mono")
;; (setq cur-font "LXGW WenKai Mono")
;; (setq cur-font "ProFontIIx NFM")
;; (setq cur-font "Sauce Code Pro Nerd Font")
;; (setq cur-font "MesloLGLDZ NF")
;; (setq cur-font "Martian Mono")
;; (setq cur-font "IBM Plex Mono")
;; (setq cur-font "Chivo Mono Medium")


;; (setq cur-font "CaskaydiaCove Nerd Font")
;; (setq cur-font "Monofur Nerd Font")

;; this one is good
(setq cur-font "JuliaMono")
(setq cur-font "DM Mono")
(setq cur-font "Hurmit Nerd Font")
(setq cur-font "IBM Plex Mono")
(setq cur-font "Ligalex Mono")
(setq cur-font "Anonymice Nerd Font")
(setq cur-font "Liga Roboto Mono")
(setq cur-font "Comic Code Ligatures")
(setq cur-font "Liga Space Mono")
(setq cur-font "saxMono")
(setq cur-font "Mononoki Nerd Font")
(setq cur-font "NK57 Monospace")
(setq cur-font "FiraCode Nerd Font")
(setq cur-font "IBM Plex Mono")
(setq cur-font "Monofur Nerd Font")
(setq cur-font "Sarasa Mono SC")
(setq cur-font "Iosevka Comfy Fixed")
(setq cur-font "Rec Mono Casual")
(setq cur-font "JetBrains Mono Nerd Font")
(setq cur-font "Hack Nerd Font")
(setq cur-font "VictorMono Nerd Font")

(setq en-font-size 14)
(setq ch-font "LXGW WenKai Mono GB")

;; (setq ch-font "IBM Plex Sans")
;; (setq cur-font "LXGW Wenkai Mono GB")
;; (setq ch-font "LXGW WenKai Mono GB")
;; (setq ch-font "Xiaolai Mono SC")
;; (setq ch-font "Yozai")
;; (setq ch-font "MaoKenTangYuan")
;; (setq ch-font "LXGW ZhenKai")
;; (setq ch-font "Source Han Serif SC Medium")
;; (setq ch-font "HanaMinA")
(setq doom-font (font-spec :family cur-font :size en-font-size)
      doom-variable-pitch-font (font-spec :family cur-font :size en-font-size)
      doom-big-font cur-font
      doom-unicode-font (font-spec :family ch-font))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq package-build-path "~/.emacs.d/.local/straight/build-27.2/")
;; (add-to-list 'custom-theme-load-path (concat package-build-path "melancholy-theme"))
;; (add-to-list 'custom-theme-load-path (concat package-build-path "alect-themes"))
(use-package! ef-themes
  :load-path "~/.config/doom/themes/ef-themes"
  :config
  (setq ef-themes-headings ; read the manual's entry of the doc string
        '((0 . (variable-pitch light 1.9))
          (1 . (variable-pitch light 1.8))
          (2 . (variable-pitch regular 1.7))
          (3 . (variable-pitch regular 1.6))
          (4 . (variable-pitch regular 1.5))
          (5 . (variable-pitch 1.4)) ; absence of weight means `bold'
          (6 . (variable-pitch 1.3))
          (7 . (variable-pitch 1.2))
          (t . (variable-pitch 1.1))))

  ;; Disable all other themes to avoid awkward blending:
  ;; (mapc #'disable-theme custom-enabled-themes)
  )

;; (setq doom-theme 'kaolin-temple)
;; (setq doom-theme 'modus-vivendi)
;; (setq doom-theme 'modus-vivendi)
;; (setq doom-theme 'doom-wilmersdorf)
;; (setq doom-theme 'whiteboard)
;; (setq doom-theme 'doom-vibrant)
;; (setq doom-theme 'kaolin-temple)
;; (setq doom-theme 'sanityinc-tomorrow-eighties)
;; (setq doom-theme 'organic-green)
;; (setq doom-theme 'nimbus)

;; (setq doom-theme 'doom-city-lights)
(setq doom-theme 'doom-laserwave)
(setq doom-theme 'doom-acario-light)
(setq doom-theme 'ef-light)
(setq doom-theme 'tango-dark)
(setq doom-theme 'kaolin-aurora)
(setq doom-theme 'twilight-bright)
(setq doom-theme 'modus-vivendi)
(setq doom-theme 'kaolin-valley-dark)
(setq doom-theme 'zweilight)
(setq doom-theme 'doom-manegarm)
(setq doom-theme 'doom-one)
(setq doom-theme 'ef-spring)
(setq doom-theme 'kaolin-aurora)

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
(map! "C-- " #'kill-current-buffer)

(defun set-input-method-to-rime ()
  (interactive)
  (if (string-equal "rime" default-input-method)
      (toggle-input-method)
    (set-input-method "rime")))

(map! "C-:" #'set-input-method-to-rime)

(map! :leader
      (:prefix-map ("j" . "Easy motion movement")
       ;; easy motion jumping
       :desc "jump goto line above" "l" #'avy-goto-line-above
       :desc "jump goto line below" "L" #'avy-goto-line-below
       :desc "goto char" "j" #'avy-goto-word-1
       :desc "goto word" "w" #'avy-goto-char-2
       ;; slurping/barfing
       :desc "slurp-forward" "s" #'sp-forward-slurp-sexp
       :desc "slurp-backward" "S" #'sp-backward-slurp-sexp
       :desc "move the first sexp out" "b" #'sp-forward-barf-sexp
       :desc "move the last sexp out" "B" #'sp-backward-barf-sexp))

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
  (rime-emacs-module-header-root  "/opt/homebrew/opt/emacs/include")
  (rime-librime-root "~/.config/emacs/librime/dist")
  (rime-show-candidate 'posframe)
  (rime-user-data-dir "~/Projects/Dotfiles/fcitx/rime/")
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

  (add-hook 'nov-post-html-render-hook 'my-nov-post-html-render-hook))


;;;;;;;;;;;;;;;;;;;;;; elfeed ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;
(use-package! elfeed
  :config
  (defun my-search-print-fn (entry)
    "Print ENTRY to the buffer."
    (let* ((date (elfeed-search-format-date (elfeed-entry-date entry)))
           (title (or (elfeed-meta entry :title)
                      (elfeed-entry-title entry) ""))
           (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
           (entry-authors (concatenate-authors
                           (elfeed-meta entry :authors)))
           (title-width (- (window-width) 10
                           elfeed-search-trailing-width))
           (title-column (elfeed-format-column
                          title 100
                          :left))
           (entry-score (elfeed-format-column (number-to-string (elfeed-score-scoring-get-score-from-entry entry)) 10 :left))
           (authors-column (elfeed-format-column entry-authors 40 :left)))
      (insert (propertize date 'face 'elfeed-search-date-face) " ")

      (insert (propertize title-column
                          'face title-faces 'kbd-help title) " ")
      (insert (propertize authors-column
                          'kbd-help entry-authors) " ")
      (insert entry-score " ")))
  ;; (setq elfeed-search-print-entry-function #'my-search-print-fn)
  )

(setq url-queue-timeout 30)

(require 'elfeed-goodies)
(setq elfeed-goodies/entry-pane-size 0.5)

(use-package! ledger-mode
  :init
  (setq ledger-clear-whole-transactions 1)
  :mode "\\.ledger\\'")
;;;;;;;;;;;;;;;;;;;;;; mail config ;;;;;;;;;;;;;;;;;;;;;;
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

(defun hyl-goto-project ()
  (interactive)
  (find-file "~/Notes/Org/Projects"))

(map!
 :leader
 (:prefix ("o" . Open)
  :nv
  :desc "Open project directory" "p" #'hyl-goto-project))

;;;;;;;;;;;;; org ;;;;;;;;;;;;;;;
;;;;;;;;;;;;;
(defun insert-now-timestamp()
  "Insert org mode timestamp at point with current date and time."
  (interactive)
  (org-insert-time-stamp (current-time) t))

(use-package! scihub
 :init
 (setq scihub-download-directory "~/DataBase/Papers/"
       scihub-open-after-download t
       scihub-fetch-domain 'scihub-fetch-domains-lovescihub))

(use-package! beacon
  :custom
  (beacon-mode t))

(defun get-binary-full-path (path)
  (shell-command-to-string (format "which %s" path)))


;;(use-package! mu4e
;;
;;  :load-path "/data/app/mu-1.6.10/mu4e/"
;;  :config
;;  (setq mu4e-org-contacts-file "~/Documents/RoamNotes/20220304154932-contacts.org")
;;  (setq mu4e-mu-binary "/usr/bin/mu")
;;  (setq mu4e-get-mail-command "true")
;;
;;  ;; ;; sync
;;  (setq mu4e-update-interval 300)
;;  ;; save attachment to Documents by default
;;  (setq mu4e-attachment-dir "~/Documents")
;;  (setq mu4e-change-filenames-when-moving t)
;;  (setq mu4e-view-prefer-html t)
;;  (setq mu4e-html2text-command "html2text -utf8 -width 150")
;;
;;  (setq
;;   ;; +mu4e-backend 'mbsync
;;   sendmail-program (executable-find "msmtp")
;;   send-mail-function #'smtpmail-send-it
;;   message-sendmail-f-is-evil t
;;   message-sendmail-extra-arguments '("--read-envelope-from")
;;   message-send-mail-function #'message-send-mail-with-sendmail)
;;
;;  ;; these are required for sending email
;;  (setq smtpmail-default-smtp-server  (format "mail.%s" "hylan.ml"))
;;  (setq smtpmail-smtp-server (format "mail.%s" "hylan.ml"))
;;  (if (string-equal "personal" (getenv "DIST"))
;;      (progn
;;        (message "Add hylan Mail accounts")
;;        (setq mu4e-mu-home "~/Documents/Data/Mail-Database")
;;        (setq mu4e-get-mail-command (format "mbsync hylan"))
;;        (setq mu4e-contexts
;;              `(
;;                ,(make-mu4e-context
;;                  :name "hylan"
;;                  :enter-func
;;                  (lambda () (mu4e-message "Enter me@hylan.ml context"))
;;                  :leave-func
;;                  (lambda () (mu4e-message "Leave me@hylan.ml context"))
;;                  :match-func
;;                  (lambda (msg)
;;                    (when msg
;;                      (mu4e-message-contact-field-matches msg :to "me@hylan.ml")))
;;                  :vars
;;                  '((user-mail-address . "me@hylan.ml")
;;                    (user-full-name . "hylan")
;;                    (mu4e-drafts-folder . "/hylan/Drafts/")
;;                    (mu4e-sent-folder . "/hylan/Sent/")
;;                    (mu4e-trash-folder . "/hylan/Trash/")
;;                    (mu4e-refile-folder . "/hylan/Inbox/"))))))
;;    (progn
;;      (message "Add Cambricon Mail accounts")
;;      (setq mu4e-get-mail-command (format "mbsync cambricon"))
;;      (setq mu4e-mu-home "/data/mail/")
;;      (setq mu4e-contexts
;;            `(
;;              ,(make-mu4e-context
;;                :name "cambricon"
;;                :enter-func
;;                (lambda () (mu4e-message "Enter lanhuiying@cambricon.com context"))
;;                :leave-func
;;                (lambda () (mu4e-message "Leave lanhuiying@cambricon.com context"))
;;                :match-func
;;                (lambda (msg)
;;                  (when msg
;;                    (mu4e-message-contact-field-matches msg :to "lanhuiying@cambricon.com")))
;;                :vars
;;                '((user-mail-address . "lanhuiying@cambricon.com")
;;                  (user-full-name . "lanhuiying")
;;                  (mu4e-drafts-folder . "/cambricon/drafts/")
;;                  (mu4e-sent-folder . "/cambricon/sent/")
;;                  (mu4e-trash-folder . "/cambricon/Trash/")
;;                  (mu4e-refile-folder . "/cambricon/Inbox/")
;;                  (mu4e-compose-signature . "---\nBest wishes!\n Huiying Lan\n")
;;                  )))))))

(solaire-global-mode +1)

;; download dict from http://download.huzheng.org/
(use-package! sdcv
  :config
  (setq sdcv-dictionary-data-dir (concat (getenv "HOME") "/.local/share/stardict/dic/"))
  (setq sdcv-dictionary-simple-list
        '("朗道汉英字典5.0"
          "朗道英汉字典5.0"))
  (setq sdcv-dictionary-complete-list '("牛津英汉双解美化版"
                                        "朗道汉英字典5.0"
                                        "朗道英汉字典5.0"))
  (setq sdcv-tooltip-timeout 50)

  (map!
   :leader
   (:prefix ("d" . "translate")
    :desc "word at point in prompt" "p" #'sdcv-search-pointer+
    :desc "word at point in buffer" "P" #'sdcv-search-pointer+
    :desc "input word at in prompt" "i" #'sdcv-search-input+
    :desc "input word at in buffer" "I" #'sdcv-search-input)
   ))

(load! "org.el")
(load! "packages/mlir-mode.el")
(load! "packages/mlir-lsp-client.el")
(load! "packages/llvm-mode.el")
(load! "packages/tablegen-mode.el")
(after! mlir-mode
  (lsp-mlir-setup))

;; enable input method switch on macos
;;(load! "input.el")
;;(load! "meow-edit-config.el")

(use-package! tiny
  :config
  (tiny-setup-default))


(after! lsp-mode
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "pyright")
                    :major-modes '(python-mode)
                    :remote? t
                    :server-id 'pyright-remote
                    )
   ;; (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
   ;;                  :major-modes '(c++-mode c-mode)
   ;;                  :priority -1
   ;;                  :remote? t
   ;;                  :server-id 'clang-remote))
   )
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
                    :major-modes '(c-mode c++-mode)
                    :remote? t
                    :server-id 'c-remote
                    )
   )
  )

;; Open files in Docker containers like so: /docker:drunk_bardeen:/etc/passwd
;; (push
;;  (cons
;;   "docker"
;;   '((tramp-login-program "docker")
;;     (tramp-login-args (("exec" "-it") ("%h") ("/bin/bash")))
;;     (tramp-remote-shell "/bin/sh")
;;     (tramp-remote-shell-args ("-i") ("-c"))))
;;  tramp-methods)

(defadvice tramp-completion-handle-file-name-all-completions
    (around dotemacs-completion-docker activate)
  "(tramp-completion-handle-file-name-all-completions \"\" \"/docker:\" returns
    a list of active Docker container names, followed by colons."
  (if (equal (ad-get-arg 1) "/docker:")
      (let* ((dockernames-raw (shell-command-to-string "docker ps | perl -we 'use strict; $_ = <>; m/^(.*)NAMES/ or die; my $offset = length($1); while(<>) {substr($_, 0, $offset, q()); chomp; for(split m/\\W+/) {print qq($_:\n)} }'"))
             (dockernames (cl-remove-if-not
                           #'(lambda (dockerline) (string-match ":$" dockerline))
                           (split-string dockernames-raw "\n"))))
        (setq ad-return-value dockernames))
    ad-do-it))

;; Trigger completion immediately.
(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

;;;; vterm
;;(push (list "find-file-below"
;;            (lambda (path)
;;              (if-let* ((buf (find-file-noselect path))
;;                        (window (display-buffer-below-selected buf nil)))
;;                  (select-window window)
;;                (message "Failed to open file: %s" path))))
;;      vterm-eval-cmds)

;; (setenv "PATH"
;;         (concat
;;          "/usr/local/texlive/2023/bin/x86_64-linux/:"
;;          (getenv "PATH"))
;;         )

;; (setq python-shell-interpreter "/home/hyl/System/anaconda3/bin/python3")
;; (setq python-interpreter "/home/hyl/System/anaconda3/bin/python3")

;; (require 'hledger-mode)
;; ;; To open files with .journal extension in hledger-mode
;; (add-to-list 'auto-mode-alist '("\\.journal\\'" . hledger-mode))

;; ;; Provide the path to you journal file.
;; ;; The default location is too opinionated.
;; (setq hledger-jfile "~/.hledger.journal")


;; ;;; Auto-completion for account names
;; ;; For company-mode users,
;; (add-to-list 'company-backends 'hledger-company)

;; ;; For auto-complete users,
;; ;;(add-to-list 'ac-modes 'hledger-mode)
;; (add-hook 'hledger-mode-hook
;;           (lambda ()
;;             (setq-local ac-sources '(hledger-ac-source))))

;; ;; For easily adjusting dates.
;; (define-key hledger-mode-map (kbd "<kp-add>") 'hledger-increment-entry-date)
;; (define-key hledger-mode-map (kbd "<kp-subtract>") 'hledger-decrement-entry-date)


(use-package! hledger-mode
  :after htmlize
  :mode ("\\.journal\\'" "\\.hledger\\'")
  :commands hledger-enable-reporting
  :preface
  (defun hledger/next-entry ()
    "Move to next entry and pulse."
    (interactive)
    (hledger-next-or-new-entry)
    (hledger-pulse-momentary-current-entry))

  (defface hledger-warning-face
    '((((background dark))
       :background "Red" :foreground "White")
      (((background light))
       :background "Red" :foreground "White")
      (t :inverse-video t))
    "Face for warning"
    :group 'hledger)

  (defun hledger/prev-entry ()
    "Move to last entry and pulse."
    (interactive)
    (hledger-backward-entry)
    (hledger-pulse-momentary-current-entry))

  :bind (("C-c j" . hledger-run-command)
         :map hledger-mode-map
         ("C-c e" . hledger-jentry)
         ("M-p" . hledger/prev-entry)
         ("M-n" . hledger/next-entry))
  :init
  (setq hledger-jfile
        (expand-file-name "~/DataBase/Notes/Ledger/account.journal")
        hledger-email-secrets-file (expand-file-name "secrets.el"
                                                     emacs-assets-directory))
  ;; Expanded account balances in the overall monthly report are
  ;; mostly noise for me and do not convey any meaningful information.
  (setq hledger-show-expanded-report nil)

  (when (boundp 'my-hledger-service-fetch-url)
    (setq hledger-service-fetch-url
          my-hledger-service-fetch-url))

  :config
  (add-hook 'hledger-view-mode-hook #'hl-line-mode)
  (add-hook 'hledger-view-mode-hook #'center-text-for-reading)

  (add-hook 'hledger-view-mode-hook
            (lambda ()
              (run-with-timer 1
                              nil
                              (lambda ()
                                (when (equal hledger-last-run-command
                                             "balancesheet")
                                  ;; highlight frequently changing accounts
                                  (highlight-regexp "^.*\\(savings\\|cash\\).*$")
                                  (highlight-regexp "^.*credit-card.*$"
                                                    'hledger-warning-face))))))

  (add-hook 'hledger-mode-hook
            (lambda ()
              (make-local-variable 'company-backends)
              (add-to-list 'company-backends 'hledger-company))))

(use-package! hledger-input
  :bind (("C-c e" . hledger-capture)
         :map hledger-input-mode-map
         ("C-c C-b" . popup-balance-at-point))
  :preface
  (defun popup-balance-at-point ()
    "Show balance for account at point in a popup."
    (interactive)
    (if-let ((account (thing-at-point 'hledger-account)))
        (message (hledger-shell-command-to-string (format " balance -N %s "
                                                          account)))
      (message "No account at point")))

  :config
  (setq hledger-input-buffer-height 20)
  (add-hook 'hledger-input-post-commit-hook #'hledger-show-new-balances)
  (add-hook 'hledger-input-mode-hook #'auto-fill-mode)
  (add-hook 'hledger-input-mode-hook
            (lambda ()
              (make-local-variable 'company-idle-delay)
              (setq-local company-idle-delay 0.1))))

(use-package! google-this
  :config
  (google-this-mode 1))
