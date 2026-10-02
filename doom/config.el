;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;;
;;;
;; private credentials (slack, bilibili...) live in secrets.el, which is gitignored
;; personal values; set in secrets.el (nil when it is missing)
(defvar my/email nil)
(defvar my/work-email nil)
(load (expand-file-name "secrets.el" doom-user-dir) t)

(setq user-full-name "Huiying Lan"
      user-mail-address my/email)

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the threefor `doom-big-font-mode'; use this for
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
;; (setq cur-font "NK57 Monospace")
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


;; (setq cur-font "Monofur Nerd Font")

;; this one is good
;; (setq cur-font "JuliaMono")
;; (setq cur-font "DM Mono")
;; (setq cur-font "Hurmit Nerd Font")
;; (setq cur-font "IBM Plex Mono")
;; (setq cur-font "Ligalex Mono")
;; (setq cur-font "Liga Roboto Mono")
;; (setq cur-font "Liga Space Mono")
;; (setq cur-font "saxMono")
;; (setq cur-font "NK57 Monospace")
;; (setq cur-font "IBM Plex Mono")
;; (setq cur-font "Monofur Nerd Font")
;; ;;(setq cur-font "Rec Mono Casual")
;; (setq cur-font "JetBrains Mono Nerd Font")
;; (setq cur-font "VictorMono Nerd Font")
;; (setq cur-font "ComicShannsMono Nerd Font Mono")
;; (setq cur-font "CaskaydiaCove Nerd Font")
;; (setq cur-font "JetBrains Mono Nerd Font")
;; (setq cur-font "FiraCode Nerd Font")
;; (setq cur-font "MonegoLigatures Nerd Font")
;; (setq cur-font "Barlow Condensed")
;; (setq cur-font "Cartograph CF")
;; (setq cur-font "Monaspace Krypton Var")
;; (setq cur-font "Monaspace Radon")
;; (setq cur-font "Sudo")
;; (setq cur-font "CommitMono Nerd Font")
;; (setq cur-font "Monaspace Neon")
;; (setq cur-font "ProggyVector")
;; (setq cur-font "MonoLisa")
;; (setq cur-font "Operator Mono")
;; (setq cur-font "Monaspace Xenon Var")
;; 
(setq en-font-size 16) 
;; (setq cur-font "Monaspace Argon Var")
;; (setq cur-font "GeistMono Nerd Font Mono")
;; (setq cur-font "FiraMono Nerd Font")
;; (setq cur-font "Pes Mono")
;; (setq cur-font "Comic Code Ligatures")
;; (setq ch-font "Cascadia Next SC")
;; (setq ch-font "LXGW WenKai Mono")
(setq cur-font "Hack Nerd Font")
;; (setq cur-font "Sarasa Mono SC")
;; (setq cur-font "Lilex")
;; (setq cur-font "JetBrains Mono Nerd Font")
;; (setq cur-font "Anonymice Nerd Font")
;; (setq cur-font "Mononoki Nerd Font")
;; (setq cur-font "Pragmata Pro Mono")
;;(setq cur-font "Recursive Monospace")
;;(setq cur-font "RecMonoLinear Nerd Font Mono")
;; (setq cur-font "Lilex")
;; (setq cur-font "JetBrains Mono Nerd Font")
;; (setq cur-font "Anonymice Nerd Font")
;; (setq cur-font "Recursive Monospace")
;; (setq cur-font "ProggyCrossed")
;; (setq cur-font "Comic Code Ligatures")
;; (setq cur-font "Anonymice Nerd Font")
;; (setq cur-font "Agave Nerd Font Mono")
;; (setq cur-font "DaddyTimeMono Nerd Font")
;; (setq cur-font "Mononoki Nerd Font")
;; (setq cur-font "ProggyCrossed")
;; (setq cur-font "RecMonoLinear Nerd Font Mono")

;; (setq cur-font "LigaSrc Pro")
;; (setq cur-font "JetBrains Mono Nerd Font")
;; (setq cur-font "Iosevka Comfy Motion")
;; (setq cur-font "Comic Code Ligatures")
;; (setq cur-font "RobotoMono NF")
;; (setq cur-font "RecMonoLinear Nerd Font Mono")
;;(setq cur-font "Monaspace Neon Frozen")
;;(setq cur-font "MesloLGS Nerd Font Propo")
;; (setq cur-font "Cartograph CF")
;;(setq cur-font "mononoki")
;;(setq cur-font "0xProto")
;; (setq cur-font "Cascadia Next SC")
;; (setq cur-font "Iosevka Comfy Motion")
;; (setq cur-font "mononoki Nerd Font")
;; (setq cur-font "Cascadia Next SC")
;; (setq cur-font "ProggyCrossed")
(setq ch-font "LXGW WenKai Mono")  
(setq cur-font "Ligamit")  
(setq cur-font "Iosevka SS14") 
(setq cur-font "Monaspace Neon Frozen")  
(setq cur-font "VictorMono Nerd Font Mono")   
(setq cur-font "Pragmata Pro Mono") 
(setq cur-font "mononoki NF") 
(setq cur-font "Comic Code Ligatures")  
(setq cur-font "NK57 Monospace") 
(setq cur-font "FiraCode Nerd Font") 
(setq cur-font "Reddit Mono")  
(setq cur-font "Google Sans Code")  
(setq cur-font "IBM Plex Mono") 
;; (setq cur-font "Monaspace Krypton Var")
;;(setq cur-font "Sarasa Mono Slab SC")

;; (setq cur-font "Iosevka SS04")
;; (setq cur-font "ComicMono Nerd Font Mono")
;; (setq cur-font "OperatorMonoSSmLig Nerd Font Mono")
;;(setq cur-font "RecMonoCasual Nerd Font Mono")
;; (Setq ch-font "IBM Plex Sans")
;; (setq cur-font "LXGW Wenkai Mono GB")
;; (setq ch-font "LXGW WenKai Mono GB")
;; (setq ch-font "Xiaolai Mono SC")
;; (setq ch-font "Yozai")
;; (setq ch-font "MaoKenTangYuan")
;; (setq ch-font "LXGW ZhenKai")
;; (setq ch-font "Source Han Serif SC Medium")
;; (setq ch-font "HanaMinA")
;; retro setup, matches alacritty / dwm / firefox
(setq cur-font "PxPlus IBM VGA 8x16"  ; pixel font: keep size a multiple of 16
      ch-font "Cubic 11"
      en-font-size 32)
(setq doom-font (font-spec :family cur-font :size en-font-size)
      doom-variable-pitch-font (font-spec :family "Fuzzy Bubbles" :size 28)
      doom-big-font cur-font
      doom-unicode-font (font-spec :family ch-font)) 
;; doom-unicode-font only covers symbols; map Chinese to ch-font explicitly
(add-hook! 'after-setting-font-hook
  (dolist (script '(han cjk-misc bopomofo kana))
    (set-fontset-font t script (font-spec :family ch-font))))

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
;; (setq doom-theme 'doom-laserwave)
;; (setq doom-theme 'doom-acario-light)
;; (setq doom-theme 'ef-light)
;; (setq doom-theme 'tango-dark)
;; (setq doom-theme 'kaolin-aurora)
;; (setq doom-theme 'twilight-bright)
;; (setq doom-theme 'modus-vivendi)
;; (setq doom-theme 'kaolin-valley-dark)
;; (setq doom-theme 'zweilight)
;; (setq doom-theme 'doom-manegarm)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'ef-spring)
;; (setq doom-theme 'kaolin-aurora)
;; (setq doom-theme 'doom-miramare)
;; (setq doom-theme 'ef-tritanopia-dark)
;; (setq doom-theme 'doom-horizon)
;; (setq doom-theme 'ef-rosa)
;; (setq doom-theme 'dichromacy)
;; (setq doom-theme 'cyberpunk)
;; (setq doom-theme 'ef-tritanopia-light)
;; (setq doom-theme 'ef-duo-light)
;; (setq doom-theme 'ef-melissa-dark)
;; (setq doom-theme 'ef-arbutus)
;; (setq doom-theme 'doom-feather-dark)
;; (setq doom-theme 'doom-dracula)
;; (setq doom-theme 'doom-tokyo-night)
;; (setq doom-theme 'doom-shades-of-purple)

(load! "~/.config/doom/themes/doom-cyberpunk-neon-theme.el")
(load! "~/.config/doom/themes/doom-tokyo-night-storm-theme.el")
(load! "~/.config/doom/themes/doom-tokyo-night-moon-theme.el")
(load! "~/.config/doom/themes/doom-tokyo-night-light-theme.el")
(load! "~/.config/doom/themes/doom-tokyo-night-city-theme.el")
;; (setq! doom-theme 'doom-tokyo-night-city)
(setq! doom-theme 'doom-feather-dark)
(setq! doom-theme 'doom-tokyo-night-city)
(setq! doom-theme 'kaolin-mono-dark)
(setq! doom-theme 'doom-snazzy) 
;; retro themes; the current one is chosen by `theme` (~/System/dotfiles/themes),
;; which writes its name to ~/.config/theme/emacs-theme
(load! "~/.config/doom/themes/doom-amber-crt-theme.el")
(load! "~/.config/doom/themes/doom-vapor-night-theme.el")
(load! "~/.config/doom/themes/doom-overdose-theme.el")
(load! "~/.config/doom/themes/doom-moss-theme.el")
(setq! doom-theme
       (let ((f "~/.config/theme/emacs-theme"))
         (if (file-exists-p f)
             (intern (string-trim (with-temp-buffer (insert-file-contents f) (buffer-string))))
           'doom-amber-crt)))
;; (setq! doom-theme 'doom-oksolar-dark)
;; Doom caches the cursor colour at theme load, from whatever frame is selected --
;; under the daemon that's a tty frame, where themes fall back to "white".
;; Read it from the frame being drawn instead.
(after! evil
  (defun +evil-default-cursor-fn () (evil-set-cursor-color (face-background 'cursor)))
  (defun +evil-emacs-cursor-fn () (evil-set-cursor-color (face-foreground 'warning))))
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
  (setq deft-default-extension "org"
        deft-recursive t))

;; Rime data: the personal-infra rime/ submodule, linked to where Squirrel (macOS) and fcitx5 (Linux)
;; read it. macOS: librime and the module header from Homebrew; Linux: apt's librime-dev.
(use-package! rime
  :custom
  (rime-show-candidate 'posframe)
  (default-input-method "rime")
  (rime-user-data-dir (if (featurep :system 'macos) "~/Library/Rime" "~/.local/share/fcitx5/rime"))
  :config
  (when (featurep :system 'macos)
    (setq rime-librime-root "/opt/homebrew/opt/librime"
          rime-emacs-module-header-root "/opt/homebrew/opt/emacs-plus@30/include")))

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
(use-package elfeed-org
  :after elfeed
  :custom (rmh-elfeed-org-files '("~/Notes/Org/elfeed.org"))
  :config
  (elfeed-org))

(defun elfeed-mpv-url ()
  "Visit the current entry in mpv."
  (interactive)
  (let ((browse-url-browser-function
         #'browse-url-mpv))
    (pcase major-mode
      ('elfeed-search-mode (elfeed-search-browse-url))
      ('elfeed-show-mode (elfeed-show-visit)))))

(defun browse-url-mpv (url &optional _)
  (start-process "mpv" nil "mpv"
                 (shell-quote-wildcard-pattern URL)))


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
  (setq browse-url-browser-function 'eww-browse-url)

  (defun elfeed-yt-show-visit (&optional use-generic-p)
    (interactive "P")
    (let ((link (elfeed-entry-link elfeed-show-entry)))
      (when link
        (message "Sent to mpv: %s" link)
        (if use-generic-p
            (emms-play-url link)
          (emms-play-url link)))))

  )


;; (setq url-queue-timeout 30)
;; (require 'elfeed-goodies)
;; (setq elfeed-goodies/entry-pane-size 0.5)
;; (require 'elfeed-tube)
;; (setq elfeed-tube-auto-fetch-p nil)

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

(defun insert-now-timestamp()
  "Insert org mode timestamp at point with current date and time."
  (interactive)
  (org-insert-time-stamp (current-time) t))

(map!
 :leader
 (:prefix ("i" . insert)
  :nv
  :desc "Date" "d" #'insert-date-string
  :desc "Date" "D" #'insert-now-timestamp
  :desc "File path" "P" #'insert-file-path))

(defun hyl-goto-project ()
  (interactive)
  (find-file "~/Notes/Org/Projects"))

(map!
 :leader
 (:prefix ("o" . Open)
  :nv
  :desc "Open project directory" "p" #'hyl-goto-project))


(use-package! scihub
  :init
  (setq scihub-download-directory "~/DataBase/Papers/"
        scihub-open-after-download t
        scihub-fetch-domain 'scihub-fetch-domains-lovescihub))

(defun get-binary-full-path (path)
  (shell-command-to-string (format "which %s" path)))

(setq mu4e-path "~/System/mu/build/mu4e/")
(if (file-exists-p! mu4e-path)

    (use-package! mu4e
      :load-path mu4e-path
      :config

      (defun my/make-msgraph-attachment (filename)
        "Create JSON payload for Microsoft Graph attachment from FILENAME."
        (let* ((base64-data (with-temp-buffer
                              (insert-file-contents-literally filename)
                              (base64-encode-region (point-min) (point-max))
                              (buffer-string)))
               (name (file-name-nondirectory filename)))
          `(("@odata.type" . "#microsoft.graph.fileAttachment")
            ("name" . ,name)
            ("contentBytes" . ,base64-data)
            ("contentType" . ,(mailcap-extension-to-mime (file-name-extension filename))))))

      (defun my/extract-attachments-from-mml ()
        "Extract attachment file paths from MML attachments."
        (let (attachments)
          (goto-char (point-min))
          (while (re-search-forward "<#part.*filename=\\(\"\\)?\\([^ >\"]+\\)\\1?.*>" nil t)
            (push (match-string 2) attachments))
          (nreverse attachments)))

      (defun my/send-mail-via-msgraph (to subject text-body html-body attachment-files)
        "Send an email via Microsoft Graph API using `plz'.
Supports TO, SUBJECT, TEXT-BODY, optional HTML-BODY, and ATTACHMENT-FILES."
        (let* ((token (my/get-oauth-token-for-send))
               (to-list (mapcar (lambda (addr)
                                  `(("emailAddress" . (("address" . ,addr)))))
                                (split-string to "," t "[[:space:]]+")))
               (attachments (when attachment-files
                              (mapcar #'my/make-msgraph-attachment attachment-files)))
               (body (if html-body
                         `(("contentType" . "HTML")
                           ("content" . ,html-body))
                       `(("contentType" . "Text")
                         ("content" . ,text-body))))
               (message
                `(("message"
                   . (("subject" . ,subject)
                      ("body" . ,body)
                      ("toRecipients" . ,to-list)
                      ,@(when attachments `(("attachments" . ,attachments)))))
                  ("saveToSentItems" . t))))
          (plz 'post "https://graph.microsoft.com/v1.0/me/sendMail"
            :headers `(("Authorization" . ,(concat "Bearer " token))
                       ("Content-Type" . "application/json"))
            :body (json-encode message)
            :as 'json)))

      (defun my/mu4e-send-via-msgraph ()
        "Custom mu4e send function using Microsoft Graph API."
        (let (to subject html-body text-body attachment-files)
          (save-excursion
            (goto-char (point-min))
            ;; Extract 'To' and 'Subject' headers manually
            (setq to (if (re-search-forward "^To: \\(.*\\)$" nil t)
                         (match-string 1)))
            (setq subject (if (re-search-forward "^Subject: \\(.*\\)$" nil t)
                              (match-string 1)))
            ;; Reset point to extract body
            (goto-char (point-min))
            (setq text-body (buffer-substring-no-properties (point-min) (point-max)))
            ;; Try to find HTML body
            (goto-char (point-min))
            (setq html-body
                  (when (re-search-forward "<html\\b.*?>.*?</html>" nil t)
                    (match-string 0)))
            ;; Get attachments from MML lines like: #+ATTACH: /path/to/file
            (setq attachment-files (my/extract-attachments-from-mml))
            ;; Send email
            (my/send-mail-via-msgraph to subject text-body html-body attachment-files)
            ;; Success
            t)))


      (setq mu4e-org-contacts-file "~/Notes/Org/contacts.org")
      (setq mu4e-mu-binary "~/System/mu/build/mu/mu")
      (setq mu4e-get-mail-command "true")
      (setq mu4e-attachment-dir "~/Documents/Attachments")
      (setq mu4e-change-filenames-when-moving t)
      (setq mu4e-update-interval 300)
      (setq mail-user-agent 'mu4e-user-agent)
   ;;; Call the oauth2ms program to fetch the authentication token
      (setq send-mail-function #'my/mu4e-send-via-msgraph)
      (setq message-send-mail-function #'my/mu4e-send-via-msgraph)

      (progn
        (message "Add hylan Mail accounts")
        ;; (setq mu4e-mu-home "~/Maildir/")
        (setq mu4e-mu-home nil)
        (setq mu4e-get-mail-command (format "mbsync Lumai"))
        (setq mu4e-contexts
              `(
                ,(make-mu4e-context
                  :name "huiying"
                  :enter-func
                  (lambda () (mu4e-message "Enter %s context" my/work-email))
                  :leave-func
                  (lambda () (mu4e-message "Leave %s context" my/work-email))
                  :match-func
                  (lambda (msg)
                    (when msg
                      (mu4e-message-contact-field-matches msg :to my/work-email)))
                  :vars
                  `((user-mail-address . ,my/work-email)
                    (user-full-name . "Huiying Lan")
                    (mu4e-drafts-folder . "/Drafts/")
                    (mu4e-sent-folder . "/Sent/")
                    (mu4e-trash-folder . "/Trash/")
                    (mu4e-refile-folder . "/Inbox/")
                    )
                  ))))
      ))
(solaire-global-mode +1)

;; download dict from http://download.huzheng.org/
;;(use-package! sdcv
;;  :config
;;  (setq sdcv-dictionary-data-dir (concat (getenv "HOME") "/.local/share/stardict/dic/"))
;;  (setq sdcv-dictionary-simple-list
;;        '("朗道汉英字典5.0"
;;          "朗道英汉字典5.0"))
;;  (setq sdcv-dictionary-complete-list '("牛津英汉双解美化版"
;;                                        "朗道汉英字典5.0"
;;                                        "朗道英汉字典5.0"))
;;  (setq sdcv-tooltip-timeout 50)
;;
;;  (map!
;;   :leader
;;   (:prefix ("d" . "translate")
;;    :desc "Translate with go-translate" "g" #'gt-do-translate
;;    :desc "word at point in prompt" "p" #'sdcv-search-pointer+
;;    :desc "word at point in buffer" "P" #'sdcv-search-pointer+
;;    :desc "input word at in prompt" "i" #'sdcv-search-input+
;;    :desc "input word at in buffer" "I" #'sdcv-search-input)
;;   )
;;  )

(load! "packages/mlir-mode.el")
;;(load! "packages/mlir-lsp-client.el")
(load! "packages/llvm-mode.el")
(load! "packages/tablegen-mode.el")
;;(after! mlir-mode
;;  (lsp-mlir-setup))
;;
;; enable input method switch on macos
;;(load! "input.el")
;;(load! "meow-edit-config.el")

(use-package! tiny
  :config
  (tiny-setup-default))

(load! "org.el")

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
        (expand-file-name "~/Notes/Ledger/account.journal")
        ;; hledger-email-secrets-file (expand-file-name "secrets.el"
        ;;                                              emacs-assets-directory)
        )
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

;; (defun copilot-complete ()
;;   (interactive)
;;   (let* ((spot (point))
;;          (inhibit-quit t)
;;          (curfile (buffer-file-name))
;;          (cash (concat curfile ".cache"))
;;          (hist (concat curfile ".prompt"))
;;          (lang (file-name-extension curfile))
;; (setq python-path "~/miniconda3"
;;       python-python-command (concat python-path "/bin/python")
;;       python-shell-interpreter python-python-command
;;       python-interpreter python-python-command
;;       org-babel-python-command python-python-command)


(require 'conda)
;; if you want interactive shell support, include:
(conda-env-initialize-interactive-shells)
;; if you want eshell support, include:
(conda-env-initialize-eshell)
;; if you want auto-activation (see below for details), include:
(conda-env-autoactivate-mode t)
;; if you want to automatically activate a conda environment on the opening of a file:
(add-hook 'find-file-hook (lambda () (when (bound-and-true-p conda-project-env-path)
                                       (conda-env-activate-for-buffer))))

(setq! conda-anaconda-home (expand-file-name "~/miniforge3"))
(setq!
 conda-env-home-directory 'conda-anaconda-home
 conda-env-subdirectory "envs")

(after! license-snippets
  (license-snippets-init))

(use-package! gt
  :config
  (setq gt-langs '(en zh))
  (setq gt-preset-translators
        `((ts-1 . ,(gt-translator
                    :taker (gt-taker :langs '(en zh) :text 'word)
                    :engines (gt-bing-engine)
                    :render (gt-overlay-render)))
          (ts-2 . ,(gt-translator
                    :taker (gt-taker :langs '(en zh) :text 'sentence)
                    :engines (gt-google-engine)
                    :render (gt-insert-render)))
          (ts-3 . ,(gt-translator
                    :taker (gt-taker :langs '(en zh) :text 'buffer
                                     :pick 'word :pick-pred (lambda (w) (length> w 6)))
                    :engines (gt-google-engine)
                    :render (gt-overlay-render :type 'help-echo)))))

  (map!
   :leader
   (:prefix ("d" . "translate")
    :desc "Translate with go-translate" "g" #'gt-do-translate))
  )

(add-hook! 'rainbow-mode-hook
  (hl-line-mode (if rainbow-mode -1 +1)))

(use-package! protobuf-mode
  :mode ("\\.proto\\'" . protobuf-mode))


(load! "packages/exec-path-from-shell.el")
(when (daemonp)
  (exec-path-from-shell-initialize))

(use-package! alert
  :commands (alert)
  :init
  (setq alert-default-style 'notifications))

(use-package! slack
  :after alert
  :commands (slack-start)
  :bind (("C-c S K" . slack-stop)
         ("C-c S c" . slack-select-rooms)
         ("C-c S u" . slack-select-unread-rooms)
         ("C-c S U" . slack-user-select)
         ("C-c S s" . slack-search-from-messages)
         ("C-c S J" . slack-jump-to-browser)
         ("C-c S j" . slack-jump-to-app)
         ("C-c S e" . slack-insert-emoji)
         ("C-c S E" . slack-message-edit)
         ("C-c S r" . slack-message-add-reaction)
         ("C-c S t" . slack-thread-show-or-create)
         ("C-c S g" . slack-message-redisplay)
         ("C-c S G" . slack-conversations-list-update-quick)
         ("C-c S q" . slack-quote-and-reply)
         ("C-c S Q" . slack-quote-and-reply-with-link)

         :map slack-mode-map
         ("@" . slack-message-embed-mention)
         ("#" . slack-message-embed-channel)

         :map slack-thread-message-buffer-mode-map
         ("C-c '" . slack-message-write-another-buffer)
         ("@" . slack-message-embed-mention)
         ("#" . slack-message-embed-channel)

         :map slack-message-buffer-mode-map
         ("C-c '" . slack-message-write-another-buffer)

         :map slack-message-compose-buffer-mode-map
         ("C-c '" . slack-message-send-from-buffer))

  :custom
  (slack-extra-subscribed-channels
   (mapcar #'intern '("some-channel")))

  :config
  (setq slack-buffer-emojify t)

  ;; teams + tokens/cookies are registered from secrets.el (gitignored)
  ) 

;; Option A: let the desktop decide (cleanest on Linux)
;; (setq browse-url-browser-function 'browse-url-xdg-open)

;; Option B: call firefox directly, no -remote nonsense
;; (setq browse-url-browser-function 'browse-url-generic
;;       browse-url-generic-program "firefox") 
(setq browse-url-firefox-new-window-is-tab t) 
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox"
      browse-url-generic-args '("--new-tab"))  


(use-package! claude-code-ide
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools


(use-package! org-trello
  :commands (org-trello-mode)
  :config
  ;; Optional: set credentials directly instead of using the file
  ;; (setq org-trello-consumer-key "your-32-char-key"
  ;;       org-trello-access-token "your-64-char-token")
  )

(setq auth-sources '("~/.authinfo"))

(use-package! msgpack)
(use-package! tramp-rpc)


;; LSP via lsp-proxy for python / go / rust / typescript (eglot keeps cc + latex)
(load! "lsp-proxy.el")

(load! "worknotes.el")

;; Center text in org / markdown buffers (visual-fill-column is already pulled in by nov / zen)
(setq-default visual-fill-column-width 100
              visual-fill-column-center-text t)
(add-hook! (org-mode markdown-mode) #'visual-fill-column-mode)
