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
;; UbuntuMono NF
;; InconsolataLGC NF
;; VictorMono NF
(setq doom-font (font-spec :family "VictorMono NF" :size 18 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Liberation Mono" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq package-build-path "~/.emacs.d/.local/straight/build-27.2/")
;; (add-to-list 'custom-theme-load-path (concat package-build-path "melancholy-theme"))
;; (add-to-list 'custom-theme-load-path (concat package-build-path "alect-themes"))
(setq doom-theme 'avk-darkblue-white)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq
 gtd_files (concat (getenv "HOME") "/Documents/RoamNotes/gtd/")
 org_notes (concat (getenv "HOME") "/Documents/RoamNotes/")
 work_org_notes (concat (getenv "HOME") "/Documents/RoamNotes/works/")
 bib_file (concat (getenv "HOME") "/Documents/RoamNotes/bibliography/ref.bib")
 org-directory org_notes
 deft-directory org_notes
 org-roam-directory org-directory)


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

(after! org
  (require 'ox-latex)
  ;;(setq org-latex-inputenc-alist '(("utf8" . "utf8x")))
  (setq org-latex-compiler "xelatex")

  (unless (boundp 'org-latex-classes)
    (setq org-latex-classes nil))

  (add-to-list 'org-latex-classes
               '("ethz"
                 "\\documentclass[a4paper,11pt,titlepage]{memoir}
    \\usepackage[utf8]{inputenc}
    \\usepackage[T1]{fontenc}
    \\usepackage{fixltx2e}
    \\usepackage{graphicx}
    \\usepackage{longtable}
    \\usepackage{float}
    \\usepackage{wrapfig}
    \\usepackage{rotating}
    \\usepackage[normalem]{ulem}
    \\usepackage{amsmath}
    \\usepackage{textcomp}
    \\usepackage{marvosym}
    \\usepackage{wasysym}
    \\usepackage{amssymb}
    \\usepackage{hyperref}
    \\usepackage{mathpazo}
    \\usepackage{color}
    \\usepackage{enumerate}
    \\definecolor{bg}{rgb}{0.95,0.95,0.95}
    \\tolerance=1000
          [NO-DEFAULT-PACKAGES]
          [PACKAGES]
          [EXTRA]
    \\linespread{1.1}
    \\hypersetup{pdfborder=0 0 0}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


  (add-to-list 'org-latex-classes
               '("article"
                 "\\documentclass[11pt,a4paper]{article}
    \\usepackage[utf8]{inputenc}
    \\usepackage[T1]{fontenc}
    \\usepackage{fixltx2e}
    \\usepackage{graphicx}
    \\usepackage{longtable}
    \\usepackage{float}
    \\usepackage{wrapfig}
    \\usepackage{rotating}
    \\usepackage[normalem]{ulem}
    \\usepackage{amsmath}
    \\usepackage{textcomp}
    \\usepackage{marvosym}
    \\usepackage{wasysym}
    \\usepackage{amssymb}
    \\usepackage{hyperref}
    \\usepackage{mathpazo}
    \\usepackage{color}
    \\usepackage{enumerate}
    \\usepackage{ctex}
    \\definecolor{bg}{rgb}{0.95,0.95,0.95}
    \\tolerance=1000
          [NO-DEFAULT-PACKAGES]
          [PACKAGES]
          [EXTRA]
    \\linespread{1.1}
    \\hypersetup{pdfborder=0 0 0}"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")))


    (add-to-list 'org-latex-classes '("ebook"
                                      "\\documentclass[11pt, oneside]{memoir}
    \\setstocksize{9in}{6in}
    \\settrimmedsize{\\stockheight}{\\stockwidth}{*}
    \\setlrmarginsandblock{2cm}{2cm}{*} % Left and right margin
    \\setulmarginsandblock{2cm}{2cm}{*} % Upper and lower margin
    \\checkandfixthelayout
    % Much more laTeX code omitted
    "
                                    ("\\chapter{%s}" . "\\chapter*{%s}")
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")))

  )
;;;; org babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (dot . t)
   (emacs-lisp . t)
   (gnuplot . t)
   (latex . t)
   (ledger . t)         ;this is the important one for this tutorial
   (python . t)
   (sh . t)
   ))

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
   bibtex-completion-library-path '("~/Documents/Resources/" "~/Documents/Resources/Papers")
   bibtex-completion-notes-path "~/Documents/RoamNotes/bibliography/notes/"
   bibtex-completion-pdf-field "file"

   bibtex-completion-additional-search-fields '(keywords)
   bibtex-completion-display-formats
   '((article       . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${journal:40}")
     (inbook        . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} Chapter ${chapter:32}")
     (incollection  . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (inproceedings . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*} ${booktitle:40}")
     (t             . "${=has-pdf=:1}${=has-note=:1} ${year:4} ${author:36} ${title:*}"))


   ;; bibtex-completion-pdf-open-function 'find-file-other-window
   ;; ** use other process to open pdf ** ;;
   ;; bibtex-completion-pdf-open-function
   ;; (lambda (fpath)
   ;;   (call-process "open" nil 0 nil fpath))
   )

  (require 'bibtex)
  (setq bibtex-autokey-year-length 4
        bibtex-autokey-name-year-separator "-"
        bibtex-autokey-year-title-separator "-"
        bibtex-autokey-titleword-separator "-"
        bibtex-autokey-titlewords 2
        bibtex-autokey-titlewords-stretch 1
        bibtex-autokey-titleword-length 5)

  (define-key bibtex-mode-map (kbd "H-b") 'org-ref-bibtex-hydra/body)
  (define-key org-mode-map (kbd "C-c ]") 'org-ref-insert-link)

  (require 'org-ref-ivy)
  (require 'org-ref-arxiv)
  (require 'org-ref-scopus)
  (require 'org-ref-wos))

(use-package! org-ref-ivy
  :init
  (setq org-ref-insert-link-function 'org-ref-insert-link-hydra/body
        org-ref-insert-cite-function 'org-ref-cite-insert-ivy
        org-ref-insert-label-function 'org-ref-insert-label-link
        org-ref-insert-ref-function 'org-ref-insert-ref-link
        org-ref-cite-onclick-function (lambda (_) (org-ref-citation-hydra/body))))

;; ;;;;;;;;;; org roam bibtex ;;;;;;;;;;
(use-package! org-roam-bibtex
  :after org-roam
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :config
  (require 'org-ref)
  (setq orb-preformat-keywords
        '("citekey" "title" "url" "author-or-editor" "keywords" "file")
        orb-process-file-keyword t
        orb-attached-file-extensions '("pdf"))

  (setq! orb-note-actions-interface 'hydra)
  (setq org-roam-capture-templates
        '(
          ("r" "bibliography reference" plain "%?"
           :target
           (file+head "bibliography/notes/${citekey}.org"
                      (concat
                       "#+TITLE: ${title}\n"
                       "#+ROAM_KEY: cite:${=key=}\n"
                       "#+CREATED: ${date}\n"))
           :unnarrowed t)
          ("n" "bibliography reference + notes" plain
           (file "~/.doom.d/capture_tmpl/ref_notes.org")
           :target
           (file+head "bibliography/notes/${citekey}.org" "#+TITLE: ${title}\n")
           :unnarrowed t)

          ("d" "default" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)

          ("p" "project" plain
           (file "~/.doom.d/capture_tmpl/proj.org")
           :target
           (file+head "projs/${slug}.org" "#+TITLE: ${slug}\n")
           :unnarrowed t)

          ))
  )


(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame t
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
  (require 'org-contacts)
  (setq org-contacts-files '("~/Documents/RoamNotes/20220304154932-contacts.org"))
  ;; Firefox and Chrome
  (add-to-list 'org-capture-templates
               '("c" "Contact" entry
                 (file+headline "~/Documents/RoamNotes/20220304154932-contacts.org" "Cambricon")
                 "* %(org-contacts-template-name)\n :PROPERTIES:\n :BIRTHDAY: %^{yyyy-mm-dd}\n :EMAIL: %(org-contacts-template-email)\n :NOTE: %^{NOTE}\n :END:"
                 :empty-lines 1
                 :prepend t
                 :kill-buffer t))
  ;;; gtd
  (add-to-list 'org-capture-templates
               '("i" "Inbox" entry
                 (file+headline "~/Documents/RoamNotes/gtd/inbox.org" "Inbox")
                 "* TODO %?\n"
                 :empty-lines 1
                 :prepend t
                 :kill-buffer t))
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
(org-babel-do-load-languages
 'org-babel-load-languages
 '((plantuml . t))) ; this line activates plantuml

(setq org-plantuml-jar-path "/data/app/plantuml-1.2022.1.jar")


(use-package! org-agenda
  :init
  (setq org-agenda-files
               (directory-files-recursively gtd_files "\.org$"))
  (setq org-agenda-start-with-log-mode t))

(defun insert-now-timestamp()
  "Insert org mode timestamp at point with current date and time."
  (interactive)
  (org-insert-time-stamp (current-time) t))

(use-package! org-super-agenda
  :init
  ;; (let ((org-agenda-span 'day)
  ;;       (org-super-agenda-groups
  ;;        '((:name "Time grid items in all-uppercase with RosyBrown1 foreground"
  ;;                 :time-grid t
  ;;                 :transformer (--> it
  ;;                                   (upcase it)
  ;;                                   (propertize it 'face '(:foreground "RosyBrown1"))))
  ;;          (:name "Priority >= C items underlined, on black background"
  ;;                 :face (:background "black" :underline t)
  ;;                 :not (:priority>= "C")
  ;;                 :order 100))))
  ;;   (org-agenda nil "a")

  (let ((org-super-agenda-groups
         '((:auto-group t))
         ))
    (org-agenda-list))
  )

(use-package! scihub
  :init
  (setq scihub-download-directory "~/Documents/Resources/Papers"
        scihub-open-after-download t
        scihub-fetch-domain 'scihub-fetch-domains-lovescihub))

(use-package! beacon
  :init
  (setq beacon-mode t))

(when (equal "work" (getenv "DIST"))
  (use-package! org-jira
    :init
    (setq jiralib-url "http://jira.cambricon.com")
    (setq org-jira-working-dir "/data/Projects/Jira")
    (setq org-jira-custom-jqls
          '(
            ;; (:jql
            ;; "(project = MAG OR project = Inference_Platform) AND issuetype = Bug AND component in (tfu, ngpf) AND project = MAG ORDER BY status ASC, priority DESC, updated DESC"
            ;; :filename "tfu-bug")
            ;; (:jql
            ;; "(project = MAG OR project = Inference_Platform) AND type in (Epic, Story, \"New Feature\", Task, Sub-task) AND status in (已变更, 暂不处理, Open, \"In Progress\", Reopened, Done, 等待其他任务, 暂停, 待验证, 验证中) AND component in (tfu, ngpf) ORDER BY status DESC, priority DESC, updated DESC"
            ;; :filename "tfu-feature")
            ;; (:jql
            ;; "(project = MAG OR project = Inference_Platform) AND issuetype = Bug AND component in (e2e_perf) AND project = MAG ORDER BY status ASC, priority DESC, updated DESC"
            ;; :filename "e2e-perf-bug")
            ;; (:jql
            ;; "(project = MAG OR project = Inference_Platform) AND type in (Epic, Story, \"New Feature\", Task, Sub-task) AND status in (已变更, 暂不处理, Open, \"In Progress\", Reopened, Done, 等待其他任务, 暂停, 待验证, 验证中) AND component in (tfu, ngpf) ORDER BY status DESC, priority DESC, updated DESC"
            ;; :filename "e2e-perf-feature")
            ;; (:jql
            ;; "(project = MAG OR project = Inference_Platform)  AND component in (tfu, ngpf, e2e_perf) AND project = MAG AND fixVersion = mm_v0.9.0 ORDER BY status DESC, priority DESC, updated DESC"
            ;; :limit 50
            ;; :filename "tfu-v0.9")
            ;; (:jql
            ;;  "(project = MAG OR project = Inference_Platform) AND type in (Epic, Story, \"New Feature\", Task, Sub-task) AND status in (已变更, 暂不处理, Open, \"In Progress\", Reopened, Done, 等待其他任务, 暂停, 待验证, 验证中) AND component in (tfu, ngpf) AND project = MAG AND fixVersion = mm_v0.10.0 ORDER BY status DESC, priority DESC, updated DESC"
            ;;  :limit 50
            ;;  :filename "tfu-v0.10")
            ;; (:jql
            ;;  "assignee = currentUser() AND resolution = Unresolved order by updated DESC"
            ;;  :limit 50
            ;;  :filename "my-issues")
            ;; (:jql
            ;;  "(project = MAG OR project = Inference_Platform) AND issuetype = Bug AND component in (tfu, ngpf, e2e_perf) AND project = MAG AND fixVersion = mm_v0.9.0 AND status = Closed ORDER BY status ASC, priority DESC, updated DESC"
            ;;  :filename "tfu-v0.9-bugs")
            (:jql
             "(project = MAG OR project = Inference_Platform) AND issuetype = Bug AND component in (tfu, ngpf, e2e_perf) AND project = MAG AND fixVersion = mm_v0.10.0 ORDER BY status ASC, priority DESC, updated DESC"
             :filename "tfu-v0.10-bugs")
            )
          ))

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

  (use-package! ox-hugo
    :config
    (setq org-hugo-base-dir "/data/DataBase/hugo")
    :after ox)

  (with-eval-after-load 'ox
    (require 'ox-pandoc)
    (require 'ox-jira)
    (require 'ox-wk)))

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
  )
