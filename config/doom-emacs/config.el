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
;; Sarasa Mono SC Nerd
(setq doom-font (font-spec :family "Ubuntu Mono" :size 20 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Liberation Mono" :size 19))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq package-build-path "~/.emacs.d/.local/straight/build-27.2/")
(add-to-list 'custom-theme-load-path (concat package-build-path "melancholy-theme"))
(add-to-list 'custom-theme-load-path (concat package-build-path "alect-themes"))
(setq doom-theme 'gotham)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq
 org_notes (concat (getenv "HOME") "/Documents/RoamNotes/")
 bib_file (concat (getenv "HOME") "/Documents/RoamNotes/bibliography/ref.bib")
 org-directory org_notes
 deft-directory org_notes
 org-roam-directory org-directory
 org-agenda-files (list org_notes))


;;(add-to-list org-agenda-files "~/Projects/RoamNotes/*.org")

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
(map! "C-;" #'toggle-input-method)

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


(use-package! deft
  :commands deft
  :init
  (setq deft-default-extension "org"))

(use-package! org-roam
  :preface
  (defvar org-roam-directory nil)
  :config
  ;; (org-roam-setup)
  (setq org-roam-directory (expand-file-name (or org-roam-directory org_notes)
                                             org-directory)
        org-roam-verbose nil  ; https://youtu.be/fn4jIlFwuLU
        org-roam-buffer-no-delete-other-windows t ; make org-roam buffer sticky
        org-roam-completion-system 'default)
  (map! :leader
        (:prefix-map ("l" .  "roam")
         :desc "find node" "f" #'org-roam-node-find
         :desc "insert node" "i" #'org-roam-node-insert
         :desc "open node" "o" #'org-roam-open-node
         :desc "open capture" "c" #'org-roam-capture
         :desc "refile" "r" #'org-roam-refile
         (:prefix ("d" . "daily")
          :desc "open date" "d" #'org-roam-dailies-find-date
          :desc "open today" "t" #'org-roam-dailies-find-today
          ;; :desc "open today" "n" #'org-roam-dailies-find-next-note
          ;; :desc "open today" "p" #'org-roam-dailies-find-previous-nore
          :desc "open yesterday" "Y" #'org-roam-dailies-goto-yesterday
          :desc "open tomorrow" "T" #'org-roam-dailies-goto-tomorrow
          )))
  ;; Normally, the org-roam buffer doesn't open until you explicitly call
  ;; `org-roam'. If `+org-roam-open-buffer-on-find-file' is non-nil, the
  ;; org-roam buffer will be opened for you when you use `org-roam-find-file'
  ;; (but not `find-file', to limit the scope of this behavior).
  ;; (add-hook 'find-file-hook
  ;;   (defun +org-roam-open-buffer-maybe-h ()
  ;;     (and +org-roam-open-buffer-on-find-file
  ;;          (memq 'org-roam-buffer--update-maybe post-command-hook)
  ;;          (not (window-parameter nil 'window-side)) ; don't proc for popups
  ;;          (not (eq 'visible (org-roam-buffer--visibility)))
  ;;          (with-current-buffer (window-buffer)
  ;;            (org-roam-buffer--get-create)))))

  ;; Hide the mode line in the org-roam buffer, since it serves no purpose. This
  ;; makes it easier to distinguish among other org buffers.
  (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode))


;; (use-package org-roam
;;   :hook (org-load . org-roam-mode)
;;   :commands (org-roam-buffer-toggle-display
;;              org-roam-find-file
;;              org-roam-graph
;;              org-roam-insert
;;              org-roam-switch-to-buffer
;;              org-roam-dailies-date
;;              org-roam-dailies-today
;;              org-roam-dailies-tomorrow
;;              org-roam-dailies-yesterday)
;;   :preface
;;   ;; Set this to nil so we can later detect whether the user has set a custom
;;   ;; directory for it, and default to `org-directory' if they haven't.
;;   (defvar org-roam-directory nil)
;;   :init
;;   :config

;;   )


;; Since the org module lazy loads org-protocol (waits until an org URL is
;; detected), we can safely chain `org-roam-protocol' to it.
(use-package org-roam-protocol
  :after org-protocol)

;; (use-package company-org-roam
;;   :after org-roam
;;   :config
;;   (set-company-backend! 'org-mode '(company-org-roam company-yasnippet company-dabbrev)))


(use-package! rime
  :custom
  (rime-show-candidate 'posframe)
  (default-input-method "rime"))

;;; config org ref

(use-package! org-ref
  :init
  (setq
   org-ref-cite-completion-function 'org-ref-get-pdf-filename-bibtex-completion

   bibtex-completion-bibliography '("~/Documents/RoamNotes//bibliography/ref.bib")
   bibtex-completion-library-path '("~/Documents/RoamNotes//bibliography/bibtex-pdfs/")
   bibtex-completion-notes-path "~/Documents/RoamNotes/bibliography/notes/"
   ;; bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"
   bibtex-completion-notes-template-multiple-files
    (concat
     "#+TITLE: ${title}\n"
     "#+ROAM_KEY: cite:${=key=}\n"
     "* TODO Notes\n"
     ":PROPERTIES:\n"
     ":Custom_ID: ${=key=}\n"
     ":NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n"

     ":AUTHOR: ${author-abbrev}\n"
     ":JOURNAL: ${journaltitle}\n"
     ":DATE: ${date}\n"
     ":YEAR: ${year}\n"
     ":DOI: ${doi}\n"
     ":URL: ${url}\n"
     ":END:\n\n"
     ))

   (require 'bibtex)
   (setq bibtex-autokey-year-length 4
         bibtex-autokey-name-year-separator "-"
         bibtex-autokey-year-title-separator "-"
         bibtex-autokey-titleword-separator "-"
         bibtex-autokey-titlewords 2
         bibtex-autokey-titlewords-stretch 1
         bibtex-autokey-titleword-length 5
         org-ref-bibtex-hydra-key-binding (kbd "H-b"))

   (define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)

   (require 'org-ref-ivy)

   (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
         org-ref-insert-cite-function 'org-ref-cite-insert-ivy
         org-ref-insert-label-function 'org-ref-insert-label-link
         org-ref-insert-ref-function 'org-ref-insert-ref-link
         org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body))))

;;;;;;;;;; org roam bibtex ;;;;;;;;;;
(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref)

  (setq org-roam-capture-templates
        '(;; ... other templates
          ;; bibliography note template
          ("r" "bibliography reference" plain "%?"
          :target
          (file+head (concat org_notes "bibliography/notes/ref-${citekey}.org") "#+title: ${title}\n")
          :unnarrowed t)))

  ;; (setq org-roam-bibtex-preformat-keywords
  ;;  '("=key=" "title" "url" "file" "author-or-editor" "keywords"))

  (setq orb-preformat-keywords '("citekey" "author" "date"))
  (setq org-roam-capture-templates
        '(("r" "bibliography reference" plain
           "%?
  %^{author} published %^{entry-type} in %^{date}: fullcite:%\\1."
           :target
           (file+head "bibliography/${citekey}.org" "#+title: ${title}\n")
           :unnarrowed t)))

;;   (setq org-roam-capture-templates
;;         '(("r" "ref" plain (function org-roam-capture--get-point)
;;            ""
;;            :file-name "${slug}"
;;            :head "#+TITLE: ${=key=}: ${title}\n#+ROAM_KEY: ${ref}

;; - tags ::
;; - keywords :: ${keywords}

;; \n* ${title}\n  :PROPERTIES:\n  :Custom_ID: ${=key=}\n  :URL: ${url}\n  :AUTHOR: ${author-or-editor}\n  :NOTER_DOCUMENT: %(orb-process-file-field \"${=key=}\")\n  :NOTER_PAGE: \n  :END:\n\n"

;;            :unnarrowed t)))
  )

(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path (list org_notes)
   )
  )


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

;; Actually start using templates
(after! org-capture
  ;; Firefox and Chrome
  (add-to-list 'org-capture-templates
               '("P" "Protocol" entry ; key, name, type
                 (file+headline +org-capture-notes-file "Inbox") ; target
                 "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"
                 :prepend t ; properties
                 :kill-buffer t))
  (add-to-list 'org-capture-templates
               '("L" "Protocol Link" entry
                 (file+headline +org-capture-notes-file "Inbox")
                 "* %? [[%:link][%(transform-square-brackets-to-round-ones \"%:description\")]]\n"
                 :prepend t
                 :kill-buffer t))
)

;;;;;;;;;;;;;;;;;;;;;; elfeed ;;;;;;;;;;;;;;;;;;;;;
(setq url-queue-timeout 30)

(use-package! ledger-mode
     :init
     (setq ledger-clear-whole-transactions 1)
     :mode "\\.dat\\'")
;;;;;;;;;;;;;;;;;;;;;; mail config ;;;;;;;;;;;;;;;;;;;;;;
(use-package! mu4e
  :load-path "/data/app/mu-1.6.10/mu4e/"
  :init
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

  ;;; capture and store link
  (map!
   :map mu4e-headers-mode-map
   :desc "org-store-link-and-capture"
   "C-c c"
   #'mu4e-org-store-and-capture)
)

(map! "C-/" #'comment-line)
(map! "C-," #'toggle-input-method)

(defun insert-date-string ()
  (interactive)
  (insert
   (current-time-string)))

(map!
 :leader
 (:prefix ("i" . insert)
  :nv
  :desc "Date" "d" #'insert-date-string))

;;;;;;;;;;;;; org ;;;;;;;;;;;;;;;
(defvar task-type-list (list "Review" "Meeting" "Bug"))

(defun add-review-task ()
  "Read text from clipboard, and add this as a todo"
  (interactive)
  ;; get clipboard content
  (let* ((text (x-get-clipboard))
         (org-f "/data/Projects/RoamNotes/20220217164749-review.org"))

    ;; get mr id from text
    ;; insert node to review file
    ;; insert link to today
    )
  )

(use-package ejira
  :init
  (setq jiralib2-url              "http://jira.cambricon.com"
        jiralib2-auth             'basic
        jiralib2-user-login-name  "lanhuiying"
        jiralib2-token            nil

        ejira-org-directory       "/data/Projects/Jira"
        ejira-projects            '("MAG")

        ejira-priorities-alist    '(("Highest" . ?A)
                                    ("High"    . ?B)
                                    ("Medium"  . ?C)
                                    ("Low"     . ?D)
                                    ("Lowest"  . ?E))
        ejira-todo-states-alist   '(("To Do"       . 1)
                                    ("In Progress" . 2)
                                    ("Done"        . 3)))
  :config
  ;; Tries to auto-set custom fields by looking into /editmeta
  ;; of an issue and an epic.
  (add-hook 'jiralib2-post-login-hook #'ejira-guess-epic-sprint-fields)

  ;; They can also be set manually if autoconfigure is not used.
  ;; (setq ejira-sprint-field       'customfield_10001
  ;;       ejira-epic-field         'customfield_10002
  ;;       ejira-epic-summary-field 'customfield_10004)

  (require 'ejira-agenda)

  ;; Make the issues visisble in your agenda by adding `ejira-org-directory'
  ;; into your `org-agenda-files'.
  (add-to-list 'org-agenda-files ejira-org-directory)

  ;; Add an agenda view to browse the issues that
  (org-add-agenda-custom-command
   '("j" "My JIRA issues"
     ((ejira-jql "resolution = unresolved and assignee = currentUser()"
                 ((org-agenda-overriding-header "Assigned to me")))))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates plantuml

(setq org-plantuml-jar-path "/data/app/plantuml-1.2022.1.jar")

(after! org-agenda
  (add-to-list 'org-agenda-files org_notes))
