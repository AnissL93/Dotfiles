;;; org.el -*- lexical-binding: t; -*-
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;    Insert timestamp    ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org_notes (concat (getenv "HOME") "/Notes/Org/")
      roam_notes (concat (getenv "HOME") "/Notes/RoamNotes/")
      org_notes_base (concat (getenv "HOME") "/Notes"))


(setq org-directory org_notes
      deft-directory org_notes_base
      org-roam-directory roam_notes
      org-agenda-files '("~/Agenda")
      ;; org-agenda-files (directory-files-recursively (concat (concat (getenv "HOME") "/Notes") "/Gtd") "\.org$")


      org-log-done-with-time t
      org-agenda-ndays 3
      org-agenda-start-day "+0d"
      org-log-done 'time
      org-log-repeat 'time

      +org-capture-journal-file (concat org_notes "journal.org"))  

;; (setq reftex-default-bibliography '("~/Notes/References/ref.bib"))
(setq reftex-bibpath-environment-variables '(".:~/Notes/References//"))

(defun aniss/open-bib-file ()
  (interactive)
  (find-file (car reftex-default-bibliography)))

  ;;;;; latex format ;;;;;;
(require 'ox-latex)
;;(setq org-latex-inputenc-alist '(("utf8" . "utf8x")))
;; (setq org-latex-compiler "xelatex")
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
    \\usepackage{rotating}
    \\usepackage{amsmath}
    \\usepackage{textcomp}
    \\usepackage{amssymb}
    \\usepackage{hyperref}
    \\usepackage{mathpazo}
    \\usepackage{color}
    \\usepackage{enumerate}
    \\definecolor{bg}{rgb}{0.95,0.95,0.95}
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
    \\usepackage{rotating}
    \\usepackage{amsmath}
    \\usepackage{textcomp}
    \\usepackage{amssymb}
    \\usepackage{hyperref}
    \\usepackage{mathpazo}
    \\usepackage{color}
    \\usepackage{enumerate}
    \\definecolor{bg}{rgb}{0.95,0.95,0.95}
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
   (plantuml . t)
   ))

(setq org-plantuml-jar-path "/data/app/plantuml-1.2022.1.jar")

;; Actually start using templates
;; Actually start using templates
;; (after! org-capture
;;   (require 'org-protocol-capture-html)
;;   (require 'org-protocol)
;;   (setq org-protocol-default-template-key nil)
;;   (setq org-html-validation-link nil)
;;   (setq enable-local-variables t)

;;   (setq org-contacts-files '("~/Notes/RoamNotes/20220304154932-contacts.org"))
;;   ;; Firefox and Chrome
;;   (setq org-capture-templates
;;         '(
;;           ("i" "Inbox" entry
;;            (file+headline "~/Notes/Org/Gtd/Inbox.org" "Inbox")
;;            "* TODO %?\n"
;;            :empty-lines 1
;;            :prepend t
;;            :kill-buffer t)
;;           ("b" "Protocol" entry
;;            (file+headline "~/Notes/RoamNotes/20220213034655-inbox.org" "WebCapture")
;;            "* %:description\nSource: %t\n[[%:link][%:description]]\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"
;;            :append
;;            )
;;           ;; link for linkz
;;           ("o" "Link capture" entry
;;            (file+headline "~/Notes/RoamNotes/org-linkz/Linkz.org" "INBOX")
;;            "* %a %U" :immediate-finish t)
;;           ("w"
;;            "Web selection"
;;            entry
;;            (file+headline "~/Notes/RoamNotes/20220213034655-inbox.org" "WebNotes")
;;            "* %:description :website:\n\n  Date: %u\n  Source: %:link\n\n  %:initial"
;;            :empty-lines 1)

;;           ("x" "Web site" entry
;;            (file+headline "~/Notes/RoamNotes/20220213034655-inbox.org" "WebPages")
;;            "* %:description :website:\n\n  Date: %u\n  Source: %:link\n\n  %:initial"
;;            :empty-lines 1)

;;           ("c" "Citation" plain
;;            (file "~/DataBase/Papers/References/ref.bib")
;;            "%:initial"
;;            :empty-lines 1
;;            :prepend t
;;            :kill-buffer t)

;;             ;;;;;; Get things done ;;;;;;
;;           ("g" "Templates for Get things done")
;;           ("gm" "Meeting/Appointment" entry
;;            (file+headline "~/Notes/Org/Gtd/Meetings.org" "Meetings")
;;            "* %^{title}\nSCHEDULED: <%(org-read-date)> \nADDED: %t\nPEOPLE: %^{people}")
;;           ("gt" "Personal todo" entry
;;            (file+headline +org-capture-todo-file "Inbox")
;;            "* [ ] %?\n%i\n%a" :prepend t)


;;           ("n" "Personal notes" entry
;;            (file+headline +org-capture-notes-file "Inbox")
;;            "* %u %?\n%i\n%a" :prepend t)
;;           ("j" "Journal" entry
;;            (file+olp+datetree +org-capture-journal-file)
;;            "* %U %?\n%i\n%a" :prepend t)

;;           ("r" "Research")
;;           ("rp" "PaperReading" entry
;;            (file+olp+datetree "~/Notes/Org/Gtd/PaperReading.org")
;;            "* %U %?\n%i\n%a" :prepend t)

;;           ("p" "Templates for projects")
;;           ("pt" "Project-local todo" entry
;;            (file+headline +org-capture-project-todo-file "Inbox")
;;            "* TODO %?\n%i\n%a" :prepend t)
;;           ("pn" "Project-local notes" entry
;;            (file+headline +org-capture-project-notes-file "Inbox")
;;            "* %U %?\n%i\n%a" :prepend t)
;;           ("pc" "Project-local changelog" entry
;;            (file+headline +org-capture-project-changelog-file "Unreleased")
;;            "* %U %?\n%i\n%a" :prepend t)
;;           ("pp" "Project-local" entry
;;            (file+headline "Projects/proj.org" "Inbox")
;;            "* %U %?\n%i\n" :prepend t)
;;           )))

(use-package! org-roam
  :init
  (setq org-roam-database-connector 'sqlite-builtin)
  :after org
  :preface
  (defvar org-roam-directory nil)
  :config
  (setq org-roam-database-connector 'sqlite-builtin)
  ;;(advice-remove 'org-roam-db-query '+org-roam-try-init-db-a)
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?" :target
           (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
           :unnarrowed t)
          ("r" "bibliography reference" plain "%?"
           :target
           (file+head "bibliography/notes/${citekey}.org"
                      (concat
                       "#+TITLE: ${title}\n"
                       "#+ROAM_KEY: cite:${=key=}\n"
                       "#+CREATED: ${date}\n"))
           :unnarrowed t)

          ("n" "bibliography reference + notes" plain
           (file "~/.config/doom/capture_tmpl/ref_notes.org")
           :target
           (file+head "Reference/Notes/${citekey}.org" "#+TITLE: ${title}\n")
           :unnarrowed t)

          ("m" "Markdown" plain "" :target
           (file+head "%<%Y-%m-%dT%H%M%S>-${slug}.md"
                      "---\ntitle: ${title}\nid: %<%Y-%m-%dT%H%M%S>\ncategory: \n---\n")
           :unnarrowed t)

          ("a" "Annotation" entry "* %<%Y-%m-%d-%H:%M:%S>\n ${body}\n"
           :target
           (file-olp "${slug}.org" "%<%Y-%m-%d-%H:%M:%S>")
           :empty-lines 1
           :unnarrowed t
           :append)
          ))

  (org-roam-bibtex-mode)
  (setq org-roam-directory (expand-file-name (or org-roam-directory org_notes)
                                             org-directory)
        org-roam-verbose nil  ; https://youtu.be/fn4jIlFwuLU
        org-roam-buffer-no-delete-other-windows t ; make org-roam buffer sticky
        org-roam-completion-system 'default)

  (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode))
                                        ; end of org-roam

(use-package! md-roam
  :config
  (setq org-roam-file-extensions '("org" "md"))
  (md-roam-mode 1)
  (setq md-roam-file-extension "md")
  ;;(org-roam-db-autosync-mode 1)
  )

(use-package! org-ref
  :init
  (setq
   org-ref-notes-function 'orb-edit-note
   org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-bibtex-completion

   bibtex-completion-bibliography (directory-files-recursively
                                   "~/Notes/References/"
                                   ".*\.bib")
   ;; directory-files-no-dot-files-regexp false)

   bibtex-completion-library-path '("~/DataBase/Papers/")
   bibtex-completion-notes-path "~/Notes/Org/"
   bibtex-completion-notes-template-multiple-files "* ${author-or-editor}, ${title}, ${journal}, (${year}) :${=type=}: \n\nSee [[cite:&${=key=}]]\n"
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
        '("citekey" "title" "url" "author-or-editor" "keywords" "file" "year" "booktitle")
        ;; nil => %^{file} is the raw `file' field of the bib entry, not a
        ;; disk-verified attachment path (which silently drops stale paths).
        orb-process-file-keyword nil
        orb-attached-file-extensions '("pdf")
        orb-note-actions-interface 'ivy
        orb-insert-interface 'ivy-bibtex)
  ;; Create reference notes through orb so %^{file}/%^{citekey} get filled
  ;; from the selected bib entry. Plain `org-roam-capture' does NOT do this.
  (map! :leader
        :desc "Insert bib note link (orb)" "n B" #'orb-insert-link))

(use-package! org-noter
  :after (:any org pdf-view)
  :config
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'horizontal-split
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   ;; Everything is relative to the main notes file
   org-noter-notes-search-path (list org_notes)
   org-noter-highlight-selected-text t
   ))

(require 'org-roam-protocol)

(defun aniss/add-timestamp-to-headline ()
  "Set time stamp to current headline"
  (interactive)
  (evil-open-below 1)
  (insert-now-timestamp))

(setq org-after-todo-state-change-hook nil)

(use-package! org-board
  :config
  (map! :leader
        (:prefix-map ("m")
                     (:prefix ("l" . "+link")
                      :desc "org-board-archive" "a" #'aniss/archive-link-and-open))))
(require 'org-ref-ivy)
(require 'org-ref-arxiv)
(require 'org-ref-scopus)
(require 'org-ref-wos)

(use-package! ox-extra
  :config
  (ox-extras-activate '(latex-header-blocks ignore-headlines)))

(use-package! easy-hugo
  :init
  (setq easy-hugo-basedir "~/Notes/AnissL93.github.io/")
  (setq easy-hugo-sshdomain "server")
  (setq easy-hugo-default-ext "org")
  (setq easy-hugo-postdir "content/posts")
  (setq easy-hugo-server-flags "-D")

  :bind
  ("C-c C-k" . easy-hugo-menu)
  :config
  (easy-hugo-enable-menu))


(advice-remove 'org-link-search '+org--recenter-after-follow-link-a)

  ;;;; org remark
(org-remark-global-tracking-mode +1)
;; Optional if you would like to highlight websites via eww-mode
(with-eval-after-load 'eww
  (org-remark-eww-mode +1))

;; Key-bind `org-remark-mark' to global-map so that you can call it
;; globally before the library is loaded.

(define-key global-map (kbd "C-c n m") #'org-remark-mark)

;; The rest of keybidings are done only on loading `org-remark'
(with-eval-after-load 'org-remark
  (define-key org-remark-mode-map (kbd "C-c n o") #'org-remark-open)
  (define-key org-remark-mode-map (kbd "C-c n ]") #'org-remark-view-next)
  (define-key org-remark-mode-map (kbd "C-c n [") #'org-remark-view-prev)
  (define-key org-remark-mode-map (kbd "C-c n r") #'org-remark-remove))

;; (setq python-interpreter "/home/hyl/System/anaconda3/bin/python")
;; (setq python-shell-interpreter "/home/hyl/System/anaconda3/bin/python")

;; (use-package! chatgpt
;;   :defer t
;;   :config
;;   (unless (boundp 'python-interpreter)
;;     (defvaralias 'python-interpreter 'python-shell-interpreter))
;;   (setq chatgpt-repo-path (expand-file-name "straight/repos/ChatGPT.el/" doom-local-dir))
;;   (set-popup-rule! (regexp-quote "*ChatGPT*")
;;     :side 'bottom :size .5 :ttl nil :quit t :modeline nil)
;;   :bind ("C-c q" . chatgpt-query))

;; (use-package! ob-chatgpt
;;   :after '(chatgpt))

;; (defun chatgpt-translate (input)
;;   (interactive (list (if (region-active-p)
;;                          (buffer-substring-no-properties (region-beginning) (region-end))
;;                        (read-from-minibuffer "ChatGPT Query: "))))

;;   (setq full-input (concat "I want you to act as an English translator, spelling corrector and improver. I will speak to you in any language and you will detect the language, translate it and answer in the corrected and improved version of my text, in English. I want you to replace my simplified A0-level words and sentences with more beautiful and elegant, upper level English words and sentences. Keep the meaning same, but make them more literary. I want you to only reply the correction, the improvements and nothing else, do not write explanations. My first sentence is: " input))
;;   (deferred:$
;;    (deferred:next
;;     (lambda ()
;;       (chatgpt-query full-input)))
;;    (deferred:nextc it
;;                    (lambda ()
;;                      (insert chatgpt-response)))))

;; (defun chatgpt-trans-kill-ring ()
;;   "Send the content in kill-ring to chatgpt for translation, and insert the response to current point."
;;   (interactive)
;;   (setq full-input (concat "I want you to act as an English translator, spelling corrector and improver. I will speak to you in any language and you will detect the language, translate it and answer in the corrected and improved version of my text, in English. I want you to replace my simplified A0-level words and sentences with more beautiful and elegant, upper level English words and sentences. Keep the meaning same, but make them more literary. I want you to only reply the correction, the improvements and nothing else, do not write explanations. My first sentence is: "
;;                            (substring-no-properties (car kill-ring))))
;;   (deferred:$
;;    (deferred:next
;;     (lambda ()
;;       (chatgpt-query full-input)))
;;    (deferred:nextc it
;;                    (lambda ()
;;                      (insert chatgpt-response)))))

(require 'ox-ioslide)


(defun filename ()
  "Copy the full path of the current buffer."
  (interactive)
  (kill-new (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(defun aniss/org-screenshot ()
  "Take a screenshot, save to default-directory/img/, and insert to current point."
  (interactive)
  (setq __img_path (concat org_notes "Images"))
  (setq pic_path
        (replace-regexp-in-string "\n" "" (shell-command-to-string (concat "~/.config/Scripts/screenshot "  __img_path ))))
  (insert (format "[[%s]]" pic_path)))

(map!
 :leader
 (:prefix ("i" . insert)
  :nv
  :desc "Screenshots" "S" #'aniss/org-screenshot))

;; Minimal UI
(package-initialize)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;  (modus-themes-load-operandi)

;; Choose some fonts
;; (set-face-attribute 'default nil :family "Iosevka")
;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
;; (set-face-attribute 'org-modern-symbol nil :family "Iosevka")

;; Add frame borders and window dividers
(modify-all-frames-parameters
 '((right-divider-width . 40)
   (internal-border-width . 40)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-ellipsis "…"

 ;; Agenda styling
 org-agenda-tags-column 0
 org-agenda-block-separator ?─
 org-agenda-time-grid
 '((daily today require-timed weekly)
   (800 1000 1200 1400 1600 1800 2000)
   " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
 org-agenda-current-time-string
 "◀── now ─────────────────────────────────────────────────")

(global-org-modern-mode)

(use-package! org-excalidraw
  :config
  (setq org-excalidraw-directory "~/Notes/Assets/")
  (defun org-excalidraw--handle-file-change (event)
    "Handle file update EVENT to convert files to svg."
    ;; (cadr event) can be 'changed or 'renamed
    ;; e.g. for changed (10 changed /some/where/ID.excalidraw)
    ;; e.g. for renamed (10 renamed /some/where/ID.excalidraw.crswap /some/where/ID.excalidraw)
    ;; note we use memq, because comparing symbols
    (when (memq (cadr event) '(changed renamed))
      ;; use eq because comparing symbols
      (let ((filename (if (eq (cadr event) 'changed)
                          (caddr event)
                        (cadddr event))))
        (when (string-suffix-p ".excalidraw" filename)
          (shell-command (org-excalidraw--shell-cmd-to-svg filename)))))))


;; (use-package! edraw
;;   :load-path "~/.config/emacs/.local/straight/repos/el-easydraw/"
;;   :config
;;   (require 'edraw-org)
;;   (edraw-org-setup-default)
;;   (with-eval-after-load "ox"
;;     (require 'edraw-org)
;;     (edraw-org-setup-exporter)))

;; (use-package! notdeft
;;   :config
;;   (setq notdeft-extension "org")
;;   ;;(setq notdeft-secondary-extensions '("md" "org" "scrbl"))
;;   (setq notdeft-xapian-program "~/System/notdeft/xapian/notdeft-xapian")
;;   (setq notdeft-directories '("~/Notes/"
;;                               "~/Agenda"))

;;   :bind (:map notdeft-mode-map
;;               ("C-q" . notdeft-quit)
;;               ("C-r" . notdeft-refresh)
;;               ))

(use-package! org-media-note
  :init (setq org-media-note-use-org-ref t)
  :hook (org-mode .  org-media-note-mode)
  :bind (
         ("H-v" . org-media-note-show-interface))  ;; 主功能入口
  :config
  (setq org-media-note-screenshot-image-dir "~/Notes/Assets/")  ;; 用于存储视频截图的目录
  (setq org-media-note-use-refcite-first t)  ;; 插入链接时，优先使用refcite链接
  )

;; bilibili-cookie-text is set in secrets.el (gitignored)

;;; -*- lexical-binding: t; -*-
;;; ─── Org agenda + TODO configuration ──────────────────────────────

;;; Agenda files — every .org file in ~/org/ is picked up automatically
(setq org-agenda-files '("~/Agenda/"))

;;; TODO keywords ─────────────────────────────────────────────────────
;; NEXT / IMPORTANT sit before `|' so they count as active states.
(setq org-todo-keywords
      '((sequence
         "TODO(t)"         ; ready to do
         "PROJ(p)"         ; ongoing, multi-step project
         "INPROCESS(s)"    ; in progress
         "☟ NEXT(n)"       ; next action
         "✰ IMPORTANT(i)"  ; high priority
         "⚑ WAITING(w)"    ; paused / blocked
         "|"
         "DONE(d)"         ; completed
         "✘ CANCELED(c@)") ; aborted / no longer applicable
        (sequence
         "✍ NOTE(N)" "FIXME(f)" "☕ BREAK(b)" "❤ LOVE(l)"
         "|"
         "REVIEW(r)"))
      org-todo-keyword-faces
      '(("TODO"        . (:foreground "#ff39a3" :weight bold))
        ("INPROCESS"   . "orangered")
        ("☟ NEXT"      . (:foreground "DeepSkyBlue" :weight bold))
        ("✰ IMPORTANT" . (:foreground "greenyellow" :weight bold))
        ("⚑ WAITING"   . "pink")
        ("DONE"        . "#008080")
        ("✘ CANCELED"  . (:foreground "white" :background "#4d4d4d" :weight bold))
        ("☕ BREAK"     . "gray")
        ("❤ LOVE"      . (:foreground "VioletRed4" :weight bold))
        ("FIXME"       . "IndianRed")))

;;; Agenda behaviour ──────────────────────────────────────────────────
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-include-diary nil
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-with-log-mode t)

(after! org
  (add-to-list 'org-modules 'org-habit))   ; habit tracking

;;; org-super-agenda ──────────────────────────────────────────────────
(use-package! org-super-agenda
  :after org-agenda
  :config
  ;; Keep evil j/k working on agenda group headers.
  (setq org-super-agenda-header-map (make-sparse-keymap))
  (org-super-agenda-mode))

;;; Custom agenda commands — per-file layout ──────────────────────────
(after! org-agenda
  (setq org-agenda-custom-commands
        '(("u" "Super Agenda"
           ((agenda "" ((org-agenda-span 2)
                        (org-agenda-start-day "-1d")
                        (org-super-agenda-groups
                         '((:name "Today List"
                            :time-grid t
                            :date today
                            :todo "INPROCESS"
                            :scheduled today
                            :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '(;; routines show in the agenda block above —
                            ;; discard here so the backlog isn't duplicated
                            (:discard (:tag ("daily" "chore" "routine")))
                            (:name "Overdue"      :deadline past       :order 2)
                            (:name "Due Today"    :deadline today      :order 3)
                            (:name "Due Soon"     :deadline future     :order 4)
                            (:name "Important"    :todo "✰ IMPORTANT"  :order 5)
                            (:name "Next actions" :todo "☟ NEXT"       :order 6)
                            (:name "Waiting"      :todo "⚑ WAITING"    :order 7)
                            (:name "To read"      :tag ("book" "reading") :order 8)
                            (:name "Trivial"      :priority<= "C"      :order 90)
                            ;; everything else grouped by project file
                            (:auto-category t :order 10)))))))

          ("D" "Daily — today's focus"
           ((agenda "" ((org-agenda-span 1)
                        (org-agenda-start-day "+0d")
                        (org-agenda-overriding-header "")
                        (org-super-agenda-groups
                         '((:name "▶ In progress"
                            :todo "INPROCESS"
                            :order 1)
                           (:name "▶ Routines"
                            :tag ("daily" "chore" "routine")
                            :time-grid t
                            :order 2)
                           (:name "▶ Due today"
                            :deadline today
                            :order 3)
                           (:name "▶ Scheduled today"
                            :scheduled today
                            :order 4)
                           (:name "▶ Next"
                            :todo "☟ NEXT"
                            :order 5)))))))
          ("b" . "BOOK")
          ("bb" "Search book tags in todos, notes, archives"
           search "+{:book\\|books:}")
          ("bd" "Book TODO list"
           search "+{^\\*+\\s-+\\(INPROCESS\\|TODO\\|⚑ WAITING\\)\\s-} +{:book\\|books:}")
          ("d" "All DONE / CANCELED tasks"
           search "+{^\\*+\\s-+\\(DONE\\|✘ CANCELED\\)\\s-}")
          ("i" "All INPROCESS tasks"
           search "+{^\\*+\\s-+\\(INPROCESS\\)\\s-}") 

          ("p" . "PROJECT")
          ("pp" "Project dashboard"
           ((agenda "" ((org-agenda-span 'month)
                        (org-agenda-start-day "-7d")
                        (org-agenda-overriding-header "▶ Timeline")))
            (alltodo "" ((org-agenda-overriding-header "▶ All tasks")
                         (org-super-agenda-groups
                          '((:name "In progress"  :todo "INPROCESS"            :order 1)
                            (:name "Important"    :todo "✰ IMPORTANT"          :order 2)
                            (:name "Next"         :todo "☟ NEXT"               :order 3)
                            (:name "Waiting"      :todo "⚑ WAITING"            :order 4)
                            (:name "Overdue"      :deadline past               :order 5)
                            (:name "Due soon"     :deadline future             :order 6)
                            (:name "Backlog"      :todo "TODO"                 :order 7)
                            (:name "Notes"        :todo "✍ NOTE"               :order 8)
                            (:name "Done"         :todo ("DONE" "✘ CANCELED")  :order 99)))))))
          
          )))  

(defun my/org-agenda-project-view ()
  "Show the project dashboard for a file or tag of your choosing."
  (interactive)
  (let ((mode (read-char-choice
               "Project scope — [f]ile or [t]ag? " '(?f ?t))))
    (pcase mode
      (?f (let* ((file (read-file-name "Project file: " "~/Agenda/" nil t))
                 (org-agenda-files (list file)))
            (org-agenda nil "pp")))
      (?t (let* ((tag (completing-read
                       "Project tag: "
                       (org-global-tags-completion-table)))
                 (org-agenda-tag-filter-preset (list (concat "+" tag))))
            (org-agenda nil "pp"))))))

(map! :leader
      :desc "Org project view" "o p" #'my/org-agenda-project-view)


;;; Capture into the per-file structure ───────────────────────────────
;; If you already define org-capture-templates elsewhere, merge these in.
(after! org                             ;
  (require 'org-protocol)
  (require 'org-protocol-capture-html)
  (defun my/org-web-capture-file ()
    (let* ((dir (expand-file-name "~/Notes/Org/Web/Pages"))
           (title (or (plist-get org-store-link-plist :description) ""))
           (name (string-trim title))
           (name (replace-regexp-in-string "[/\\:*?\"<>|\n\r\t]" "" name))
           (name (replace-regexp-in-string "[[:space:]]+" "-" name))
           (name (if (> (length name) 80) (substring name 0 80) name))
           (name (if (string-empty-p name) "untitled" name)))
      (unless (file-directory-p dir)
        (make-directory dir t))
      (expand-file-name (concat name ".org") dir)))

  (setq org-capture-templates
        '(

          ("i" "Inbox" entry
           (file+headline "~/Agenda/inbox.org" "Inbox")
           "* TODO %?\n"
           :empty-lines 1
           :prepend t
           :kill-buffer t)

          
          ("l" "Life")
          ("ld" "Life / Daily routine" entry
           (file+headline "~/Agenda/life.org" "Daily")
           "* TODO %?\n  SCHEDULED: %(format-time-string \"<%Y-%m-%d %a +1d>\")")
          ("le" "Life / errand" entry
           (file+headline "~/Agenda/life.org" "Errands")
           "* TODO %?")

          ("p" "Project todo" entry
           (file (lambda () (read-file-name "Project file: " "~/Agenda/")))
           "* TODO %?")
          ("P" "Project task — link to current location" entry
           (file (lambda () (read-file-name "Project file: " "~/Agenda/")))
           "* TODO %?\n%a\n%U")

          ;; ── Web (org-protocol) ──
          ("w" "Web")
          ("wl" "Web link capture" entry
           (file+headline "~/Notes/Org/org-linkz/Linkz.org" "INBOX")
           "* %a %U" :immediate-finish t)
          ("wa" "Web annotation" entry
           (file+headline "~/Notes/Org/Web/Annotation.org" "Annotations")
           "* %:description\n%:annotation\n%U\n\n#+begin_quote\n%i\n#+end_quote\n\n%?")
          ("ws" "Web link + selection" entry
           (file+headline "~/Agenda/inbox.org" "Web")
           "* TODO %:description\n%:annotation\n%U\n\n#+begin_quote\n%i\n#+end_quote\n\n%?")
          ("wr" "Web page (HTML → file)" plain
           (file my/org-web-capture-file)
           "#+title: %:description\n#+date: %U\n\n%:annotation\n\n%:initial\n\n%?"
           :unnarrowed t)
          ("wi" "GitHub issue to project" entry
           (file+headline (lambda () (read-file-name "Project file: " "~/Agenda/"))
                          "Issues" )
           "* TODO %:description :issue:\n%:annotation\n%U\n%?")
          ("wI" "GitHub issue" entry
           (file+headline "~/Agenda/inbox.org" "Issues")
           "* TODO %:description :issue:\n%:annotation\n%U\n%?"
           :immediate-finish t)

          ;; -- Citation --
          ("c" "Citation" plain
           (file "~/Notes/References/ref.bib")
           "%:initial"
           :empty-lines 1
           :prepend t
           :kill-buffer t)
          ))
  ) 

;;; org-edna — task dependencies / triggers ───────────────────────────
(use-package! org-edna
  :after org
  :config
  (org-edna-mode))

;;; org-wild-notifier — desktop notifications for agenda ──────────────
(use-package! org-wild-notifier
  :after org-agenda
  :config
  ;; (setq org-wild-notifier-alert-time 15)
  (setq alert-default-style
        (if (featurep :system 'macos) 'osx-notifier 'libnotify))
  (org-wild-notifier-mode))

;;; Clocking + org-onit ("doing" tracker) ─────────────────────────────
(after! org-clock
  (setq org-clock-out-remove-zero-time-clocks t
        org-clock-clocked-in-display 'frame-title
        org-clock-frame-title-format
        '((:eval (format "%s|%s| %s"
                         (if org-onit--auto-clocking "Auto " "")
                         (org-onit-get-sign)
                         org-mode-line-string)))))

(after! org
  (add-to-list 'org-tag-faces '("Doing" :foreground "#FF0000"))
  (add-hook 'org-cycle-hook #'org-onit-clock-in-when-unfold))

(map! "C-<f11>" #'org-clock-goto
      :map org-mode-map
      "<f11>"   #'org-onit-toggle-doing
      "M-<f11>" #'org-onit-toggle-auto
      "S-<f11>" #'org-onit-goto-anchor)

(use-package! org-books
  :config
  (setq org-books-file "~/Agenda/books.org"))

(use-package! hyperdrive
  :bind ("C-c h" . hyperdrive-menu)
  :init
  (menu-bar-mode +1)
  (hyperdrive-menu-bar-mode +1)
  :config
  (context-menu-mode +1)
  (hyperdrive-context-menu-mode +1))


(use-package! org-transclusion
  :after hyperdrive
  :init
  (map!
   :map global-map "<f12>" #'org-transclusion-add
   :leader
   :prefix "n"
   :desc "Org Transclusion Mode" "t" #'org-transclusion-mode)
  )

(with-eval-after-load 'org-transclusion
  (add-to-list 'org-transclusion-extensions 'org-transclusion-indent-mode)
  (require 'org-transclusion-indent-mode))
(with-eval-after-load 'org-transclusion
  (add-to-list 'org-transclusion-extensions 'org-transclusion-http)
  (require 'org-transclusion-http))
(with-eval-after-load 'org-transclusion
  (add-to-list 'org-transclusion-extensions 'hyperdrive-org-transclusion)
  (require 'hyperdrive-org-transclusion))
(with-eval-after-load 'org-transclusion
  (hyperdrive-org-transclusion-mode +1))


(use-package! org-yt
  :init
  (defun org-image-link (protocol link _description)
    "Interpret LINK as base64-encoded image data."
    (cl-assert (string-match "\\`img" protocol) nil
               "Expected protocol type starting with img")
    (let ((buf (url-retrieve-synchronously (concat (substring protocol 3) ":" link))))
      (cl-assert buf nil
                 "Download of image \"%s\" failed." link)
      (with-current-buffer buf
        (goto-char (point-min))
        (re-search-forward "\r?\n\r?\n")
        (buffer-substring-no-properties (point) (point-max)))))

  (org-link-set-parameters
   "imghttp"
   :image-data-fun #'org-image-link)

  (org-link-set-parameters
   "imghttps"
   :image-data-fun #'org-image-link))


(use-package! org-notion
  :hook (org-mode . org-notion-mode))


(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :hook (org-agenda-finalize . org-modern-agenda)
  :config
  (setq org-modern-star 'replace
        org-modern-replace-stars "◉○✸✿"))

(use-package! org-timeblock
  :after org
  :config
  ;; optional customizations
  (setq org-timeblock-span 3)) ;; number of days shown
