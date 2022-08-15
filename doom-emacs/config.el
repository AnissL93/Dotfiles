;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(if (equal "personal" (getenv "DIST"))
    (setq user-full-name "hylan"
          user-mail-address "me@hylan.com")
  (setq user-full-name "lanhuiying"
        user-mail-address "lanhuiying@cambricon.com"))
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
;; (setq cur-font "Cascadia Code")
;; (setq cur-font "Azeret Mono")
;; (setq cur-font "Comic Code Ligatures")
;; (setq cur-font "FuraCode NF")
;; (setq cur-font "FuraCode NF")
;; (setq cur-font "FantasqueSansMono NF")
;; (setq cur-font "InconsolataLGC NF")
;; (setq cur-font "Hasklug NF")
;; (setq cur-font "Sarasa Mono SC")
;; (setq cur-font "Hurmit NF")
;; (setq cur-font "Consola Mono")
;; (setq cur-font "Anonymice NF")
;; (setq cur-font "Monoid NF")
;; (setq cur-font "Input Mono")
;; (setq cur-font "Liga Space Mono")
;; (setq cur-font "Envy Code R")
;; (setq cur-font "LXGW WenKai Mono")
;; (setq cur-font "Ligalex Mono")
;; (setq cur-font "Liga Roboto Mono")
;; (setq cur-font "CamingoCode")
;; (setq cur-font "Sometype Mono")
;; (setq cur-font "Verily Serif Mono")

;; this one is good
(setq cur-font "NK57 Monospace")
(setq en-font-size 16)
(setq doom-font (font-spec :family cur-font :size en-font-size :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family cur-font :size en-font-size)
      doom-big-font cur-font
      doom-unicode-font (font-spec :family "LXGW WenKai Mono"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq package-build-path "~/.emacs.d/.local/straight/build-27.2/")
;; (add-to-list 'custom-theme-load-path (concat package-build-path "melancholy-theme"))
;; (add-to-list 'custom-theme-load-path (concat package-build-path "alect-themes"))

;; (setq doom-theme 'kaolin-temple)
;; (setq doom-theme 'modus-vivendi)
;; (setq doom-theme 'doom-wilmersdorf)
(setq doom-theme 'apropospriate-light)

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
      (:prefix-map ("e" . "S-expression operations")
       :desc "slurp-forward" "s" #'sp-forward-slurp-sexp
       :desc "slurp-backward" "S" #'sp-backward-slurp-sexp
       :desc "move the first sexp out" "b" #'sp-backward-barf-sexp
       :desc "move the last sexp out" "B" #'sp-forward-barf-sexp)
      (:prefix-map ("j" . "Easy motion movement")
       :desc "jump goto line above" "l" #'avy-goto-line-above
       :desc "jump goto line below" "L" #'avy-goto-line-below
       :desc "goto char" "j" #'avy-goto-char
       :desc "goto word" "w" #'avy-goto-word-0))

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

(defun get-binary-full-path (path)
  (shell-command-to-string (format "which %s" path)))


(use-package! mu4e

  :load-path "/data/app/mu-1.6.10/mu4e/"
  :config
  (setq mu4e-org-contacts-file "~/Documents/RoamNotes/20220304154932-contacts.org")
  (setq mu4e-mu-binary "/usr/bin/mu")
  (setq mu4e-get-mail-command "true")

  ;; ;; sync
  (setq mu4e-update-interval 300)
  ;; save attachment to Documents by default
  (setq mu4e-attachment-dir "~/Documents")
  (setq mu4e-change-filenames-when-moving t)
  (setq mu4e-view-prefer-html t)
  (setq mu4e-html2text-command "html2text -utf8 -width 150")


  (setq
   ;; +mu4e-backend 'mbsync
   sendmail-program (executable-find "msmtp")
   send-mail-function #'smtpmail-send-it
   message-sendmail-f-is-evil t
   message-sendmail-extra-arguments '("--read-envelope-from")
   message-send-mail-function #'message-send-mail-with-sendmail)

  ;; these are required for sending email
  (setq smtpmail-default-smtp-server  (format "mail.%s" "hylan.ml"))
  (setq smtpmail-smtp-server (format "mail.%s" "hylan.ml"))
  (if (string-equal "personal" (getenv "DIST"))
      (progn
        (message "Add hylan Mail accounts")
        (setq mu4e-mu-home "~/Documents/Data/Mail-Database")
        (setq mu4e-get-mail-command (format "mbsync hylan"))
        (setq mu4e-contexts
              `(
                ,(make-mu4e-context
                  :name "hylan"
                  :enter-func
                  (lambda () (mu4e-message "Enter me@hylan.ml context"))
                  :leave-func
                  (lambda () (mu4e-message "Leave me@hylan.ml context"))
                  :match-func
                  (lambda (msg)
                    (when msg
                      (mu4e-message-contact-field-matches msg :to "me@hylan.ml")))
                  :vars
                  '((user-mail-address . "me@hylan.ml")
                    (user-full-name . "hylan")
                    (mu4e-drafts-folder . "/hylan/Drafts/")
                    (mu4e-sent-folder . "/hylan/Sent/")
                    (mu4e-trash-folder . "/hylan/Trash/")
                    (mu4e-refile-folder . "/hylan/Inbox/"))))))
    (progn
      (message "Add Cambricon Mail accounts")
      (setq mu4e-get-mail-command (format "mbsync cambricon"))
      ;; (setq mu4e-mu-home "/data/mail/")
      (setq mu4e-maildir "/data/mail/")
      (setq mu4e-contexts
            `(
              ,(make-mu4e-context
                :name "cambricon"
                :enter-func
                (lambda () (mu4e-message "Enter lanhuiying@cambricon.com context"))
                :leave-func
                (lambda () (mu4e-message "Leave lanhuiying@cambricon.com context"))
                :match-func
                (lambda (msg)
                  (when msg
                    (mu4e-message-contact-field-matches msg :to "lanhuiying@cambricon.com")))
                :vars
                '((user-mail-address . "lanhuiying@cambricon.com")
                  (user-full-name . "lanhuiying")
                  (mu4e-drafts-folder . "/cambricon/drafts/")
                  (mu4e-sent-folder . "/cambricon/sent/")
                  (mu4e-trash-folder . "/cambricon/Trash/")
                  (mu4e-refile-folder . "/cambricon/Inbox/")
                  (mu4e-compose-signature . "---\nBest wishes!\n Huiying Lan\n")
                  )))))))

(when (equal "personal" (getenv "DIST"))
  ;;
  (use-package! arduino-mode
    :init
    (setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
    (autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t))

  ;;; set proxy
  (defun auii/unset_proxy ()
    (interactive)
    (setenv "http_proxy" "")
    (setenv "https_proxy" ""))

  (defun auii/set_proxy ()
    (interactive)
    (setenv "http_proxy" "socks5://127.0.0.1:10800")
    (setenv "https_proxy" "socks5://127.0.0.1:10800"))
  (auii/set_proxy))

(solaire-global-mode +1)

;; download dict from http://download.huzheng.org/
(use-package! sdcv
  :config
  (setq sdcv-dictionary-data-dir (concat (getenv "HOME") "/.local/share/stardict/dic/"))
  (setq sdcv-dictionary-simple-list
        '("朗道汉英字典5.0"
          "朗道英汉字典5.0"))
  (setq sdcv-dictionary-complete-list '(
                                        "牛津英汉双解美化版"
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

;;;;;;; chinese fonts
(use-package! cnfonts
  :config
  (setq cnfonts-mode 1))

(load! "org.el")
(load! "packages/mlir-mode.el")
(load! "packages/mlir-lsp-client.el")
(load! "packages/llvm-mode.el")
(load! "packages/tablegen-mode.el")
(after! mlir-mode
  (lsp-mlir-setup))

;; enable input method switch on macos
(load! "input.el")

(use-package! meow
 :config
 (meow-setup-indicator)
 (setq meow--kbd-undo "C-_")
 (setq meow--kbd-forward-slurp "C-c e s") ;;tjfdskd
 (setq meow--kbd-backward-slurp "C-c e S") ;;tjfdskd
 (defun meow-setup ()
   (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
   (meow-motion-overwrite-define-key
    '("j" . meow-next)
    '("k" . meow-prev)
    '("<escape>" . ignore))
   (meow-leader-define-key
    ;; SPC j/k will run the original command in MOTION state.
    '("j" . "H-j")
    '("k" . "H-k")
    ;; Use SPC (0-9) for digit arguments.
    '("1" . meow-digit-argument)
    '("2" . meow-digit-argument)
    '("3" . meow-digit-argument)
    '("4" . meow-digit-argument)
    '("5" . meow-digit-argument)
    '("6" . meow-digit-argument)
    '("7" . meow-digit-argument)
    '("8" . meow-digit-argument)
    '("9" . meow-digit-argument)
    '("0" . meow-digit-argument)
    '("/" . meow-keypad-describe-key)
    '("?" . meow-cheatsheet))
   (meow-normal-define-key
    '("0" . meow-expand-0)
    '("9" . meow-expand-9)
    '("8" . meow-expand-8)
    '("7" . meow-expand-7)
    '("6" . meow-expand-6)
    '("5" . meow-expand-5)
    '("4" . meow-expand-4)
    '("3" . meow-expand-3)
    '("2" . meow-expand-2)
    '("1" . meow-expand-1)
    '(";" . meow--reverse)
    '("," . meow-inner-of-thing)
    '("." . meow-bounds-of-thing)
    '("[" . meow-beginning-of-thing)
    '("]" . meow-end-of-thing)
    '("a" . meow-append)
    '("o" . meow-open-below)
    '("b" . meow-back-word)
    '("B" . meow-back-symbol)
    '("c" . meow-change)
    '("d" . meow-kill)
    '("w" . meow-next-word)
    '("W" . meow-next-symbol)
    '("&" . meow-find)
    '("g" . meow-cancel-selection)
    '("G" . meow-grab)
    '("h" . meow-left)
    '("H" . meow-left-expand)
    '("i" . meow-insert)
    '("O" . meow-open-above)
    '("j" . meow-next)
    '("J" . meow-next-expand)
    '("k" . meow-prev)
    '("K" . meow-prev-expand)
    '("l" . meow-right)
    '("L" . meow-right-expand)
    '("m" . meow-join)
    '("n" . meow-search)
    '("%" . meow-block)
    '("M" . meow-to-block)
    '("p" . meow-yank)
    '("P" . meow-replace)
    '("q" . meow-quit)
    '("Q" . meow-goto-line)
    '("r" . negative-argument)
    ;; maybe change this ??
    '("U" . undo-redo)
    '("t" . meow-till)
    '("u" . meow-undo)
    '("U" . meow-undo-in-selection)
    '("s" . meow-visit)
    '("S" . meow-forward-slurp)
    ;; '("M" . meow-backward-slurp)
    '("e" . meow-mark-word)
    '("E" . meow-mark-symbol)
    '("x" . meow-line)
    '("y" . meow-save)
    '("Y" . meow-sync-grab)
    ;; '("Z" . meow-pop-selection)
    '("'" . repeat)
    '("(" . scroll-down)
    '(")" . scroll-up)
    '("<escape>" . ignore)
    ;; goto begin/end of buffer
    '("<" . beginning-of-buffer)
    '(">" . end-of-buffer)

    ;; avy-goto
    '("f" . avy-goto-word-1)
    '("F" . avy-goto-char-2)

    ;; window manage
    '("$" . save-buffer)
    '("v" . split-window-right)
    '("V" . split-window-below)
    '("C" . other-window)
    '("*" . +format/buffer)
    '("z" . recenter)

    ;; buffer manage
    '("X" . kill-current-buffer)
    '("#" . consult-buffer)
    '("/" . +default/search-buffer)))
 (meow-setup)
 (setq meow-use-clipboard t)
 )

(use-package! tiny
  :config
  (tiny-setup-default))
