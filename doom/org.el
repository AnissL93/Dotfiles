;;; org.el -*- lexical-binding: t; -*-
(after! org
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;    Insert timestamp    ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (defun insert-now-timestamp ()
    "Insert org mode timestamp at point with current date and time."
    (interactive)
    (org-insert-time-stamp (current-time) t))
  (defun insert-now-timestamp-inactive ()
    "Insert org mode timestamp at point with current date and time."
    (interactive)
    (org-insert-time-stamp (current-time) t t))
  (map! :leader
        (:prefix-map ("m")
                     (:prefix ("d" . "+data/deadline")
                      :desc "org-timestamp-now-inactive" "N" #'insert-now-timestamp-inactive
                      :desc "org-timestamp-now" "n" #'insert-now-timestamp)))
  (setq org_notes (concat (getenv "HOME") "/Notes/Org/")
        roam_notes (concat (getenv "HOME") "/Notes/RoamNotes/"))


  (setq org-directory org_notes
        deft-directory roam_notes
        org-roam-directory roam_notes
        org-agenda-files '("~/Notes/Gtd")
        ;; org-agenda-files (directory-files-recursively (concat (concat (getenv "HOME") "/Notes") "/Gtd") "\.org$")

        org-log-done-with-time t
        org-agenda-ndays 3
        org-agenda-start-day "+0d"

        +org-capture-journal-file (concat org_notes "journal.org"))

  (setq reftex-default-bibliography '("~/Notes/References/ref.bib"))
  (setq reftex-bibpath-environment-variables '(".:~/Notes/References//"))

  (defun aniss/open-bib-file ()
    (interactive)
    (find-file (car reftex-default-bibliography)))

  (setq org-agenda-custom-commands
        '(
          ("u" "Super view"
           ((agenda "" ((org-agenda-span 'day)
                        (org-agenda-use-tag-inheritance t)
                        (org-agenda-overriding-header "Agenda")
                        (org-super-agenda-groups
                         '((:name "Today"
                            :time-grid t)
                           (:name "Important"
                            :priority "A")
                           (:priority<= "B" :scheduled future :order 1)
                           ))))
            ;; (todo "" ((org-agenda-overriding-header "Important")
            ;;           (org-super-ageda-group
            ;;            '((:name "Important"
            ;;               :priority "A")
            ;;              )
            ;;            )
            ;;           ))
            (todo "" ((org-agenda-overriding-header "Grouped")
                      (org-super-agenda-groups
                       '((:auto-group t)))))
            (todo "" ((org-agenda-overriding-header "Other")
                      (org-super-agenda-groups
                       '((:auto-category t))                     )))
            ))
          ))


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
  (after! org-capture
    (require 'org-protocol-capture-html)
    (require 'org-protocol)
    (setq org-protocol-default-template-key nil)
    (setq org-html-validation-link nil)
    (setq enable-local-variables t)

    (setq org-contacts-files '("~/Notes/RoamNotes/20220304154932-contacts.org"))
    ;; Firefox and Chrome
    (setq org-capture-templates
          '(
            ("i" "Inbox" entry
             (file+headline "~/Notes/Org/Gtd/Inbox.org" "Inbox")
             "* TODO %?\n"
             :empty-lines 1
             :prepend t
             :kill-buffer t)
            ("b" "Protocol" entry
             (file+headline "~/Notes/RoamNotes/20220213034655-inbox.org" "WebCapture")
             "* %:description\nSource: %t\n[[%:link][%:description]]\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?"
             :append
             )
            ;; link for linkz
            ("o" "Link capture" entry
             (file+headline "~/Notes/RoamNotes/org-linkz/Linkz.org" "INBOX")
             "* %a %U" :immediate-finish t)
            ("w"
             "Web selection"
             entry
             (file+headline "~/Notes/RoamNotes/20220213034655-inbox.org" "WebNotes")
             "* %:description :website:\n\n  Date: %u\n  Source: %:link\n\n  %:initial"
             :empty-lines 1)

            ("x" "Web site" entry
             (file+headline "~/Notes/RoamNotes/20220213034655-inbox.org" "WebPages")
             "* %:description :website:\n\n  Date: %u\n  Source: %:link\n\n  %:initial"
             :empty-lines 1)

            ("c" "Citation" plain
             (file "~/DataBase/Papers/References/ref.bib")
             "%:initial"
             :empty-lines 1
             :prepend t
             :kill-buffer t)

            ;;;;;; Get things done ;;;;;;
            ("g" "Templates for Get things done")
            ("gm" "Meeting/Appointment" entry
             (file+headline "~/Notes/Org/Gtd/Meetings.org" "Meetings")
             "* %^{title}\nSCHEDULED: <%(org-read-date)> \nADDED: %t\nPEOPLE: %^{people}")
            ("gt" "Personal todo" entry
             (file+headline +org-capture-todo-file "Inbox")
             "* [ ] %?\n%i\n%a" :prepend t)


            ("n" "Personal notes" entry
             (file+headline +org-capture-notes-file "Inbox")
             "* %u %?\n%i\n%a" :prepend t)
            ("j" "Journal" entry
             (file+olp+datetree +org-capture-journal-file)
             "* %U %?\n%i\n%a" :prepend t)

            ("r" "Research")
            ("rp" "PaperReading" entry
             (file+olp+datetree "~/Notes/Org/Gtd/PaperReading.org")
             "* %U %?\n%i\n%a" :prepend t)

            ("p" "Templates for projects")
            ("pt" "Project-local todo" entry
             (file+headline +org-capture-project-todo-file "Inbox")
             "* TODO %?\n%i\n%a" :prepend t)
            ("pn" "Project-local notes" entry
             (file+headline +org-capture-project-notes-file "Inbox")
             "* %U %?\n%i\n%a" :prepend t)
            ("pc" "Project-local changelog" entry
             (file+headline +org-capture-project-changelog-file "Unreleased")
             "* %U %?\n%i\n%a" :prepend t)
            ("pp" "Project-local" entry
             (file+headline "Projects/proj.org" "Inbox")
             "* %U %?\n%i\n" :prepend t)
            )))

  (use-package! org-roam
    :preface
    (defvar org-roam-directory nil)

    :config
    ;;(setq org-roam-database-connector 'sqlite3)
    (org-roam-setup)
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
             (file+head "Referneces/Notes/${citekey}.org" "#+TITLE: ${title}\n")
             :unnarrowed t)

            ("m" "Markdown" plain "" :target
             (file+head "%<%Y-%m-%dT%H%M%S>-${slug}.md"
                        "---\ntitle: ${title}\nid: %<%Y-%m-%dT%H%M%S>\ncategory: \n---\n")
             :unnarrowed t)

            ;; ("a" "Annotation" plain "%?"
            ;;  :target (file+head "${slug}.org"
            ;;                     "#+title: ${title}\n#+roam_key: ${ref}\n#+roam_alias:\n")
            ;;                :immediate-finish t
            ;;                :unnarrowed t)
            ))

    ;; Template for org roam protocol
    (setq org-roam-capture-ref-templates
          '(
            ("r" "ref" plain "%?" :target
             (file+head "${slug}.org" "#+title: ${title}\n* %<%Y-%m-%d-%H:%M:%S>\n ${body}\n")
             :unnarrowed t)
            ;; ("r" "ref" plain "%?" :target
            ;; (file-headline "${slug}.org" "* %<%Y-%m-%dT%H%M%S>\n ${body}\n")
            ;; :unnarrowed t)
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

    (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode)) ;;; end of org-roam

  (use-package! md-roam
    :config
    (setq org-roam-file-extensions '("org" "md"))
    (md-roam-mode 1)
    (setq md-roam-file-extension "md")
    (org-roam-db-autosync-mode 1))

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
     bibtex-completion-notes-path "~/Notes/Papers/"
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
          orb-attached-file-extensions '("pdf")
          orb-note-actions-interface 'ivy
          orb-insert-interface 'ivy-bibtex))

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

  (use-package! org-transclusion
    :init
    (map!
     :map global-map "<f12>" #'org-transclusion-add
     :leader
     :prefix "n"
     :desc "Org Transclusion Mode" "t" #'org-transclusion-mode))

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

  (setq python-interpreter "/home/hyl/System/anaconda3/bin/python")
  (setq python-shell-interpreter "/home/hyl/System/anaconda3/bin/python")

  (use-package! chatgpt
    :defer t
    :config
    (unless (boundp 'python-interpreter)
      (defvaralias 'python-interpreter 'python-shell-interpreter))
    (setq chatgpt-repo-path (expand-file-name "straight/repos/ChatGPT.el/" doom-local-dir))
    (set-popup-rule! (regexp-quote "*ChatGPT*")
      :side 'bottom :size .5 :ttl nil :quit t :modeline nil)
    :bind ("C-c q" . chatgpt-query))

  (use-package! ob-chatgpt
    :after '(chatgpt))

  (defun chatgpt-translate (input)
    (interactive (list (if (region-active-p)
                           (buffer-substring-no-properties (region-beginning) (region-end))
                         (read-from-minibuffer "ChatGPT Query: "))))

    (setq full-input (concat "I want you to act as an English translator, spelling corrector and improver. I will speak to you in any language and you will detect the language, translate it and answer in the corrected and improved version of my text, in English. I want you to replace my simplified A0-level words and sentences with more beautiful and elegant, upper level English words and sentences. Keep the meaning same, but make them more literary. I want you to only reply the correction, the improvements and nothing else, do not write explanations. My first sentence is: " input))
    (deferred:$
      (deferred:next
        (lambda ()
          (chatgpt-query full-input)))
      (deferred:nextc it
        (lambda ()
          (insert chatgpt-response)))))

  (defun chatgpt-trans-kill-ring ()
    "Send the content in kill-ring to chatgpt for translation, and insert the response to current point."
    (interactive)
    (setq full-input (concat "I want you to act as an English translator, spelling corrector and improver. I will speak to you in any language and you will detect the language, translate it and answer in the corrected and improved version of my text, in English. I want you to replace my simplified A0-level words and sentences with more beautiful and elegant, upper level English words and sentences. Keep the meaning same, but make them more literary. I want you to only reply the correction, the improvements and nothing else, do not write explanations. My first sentence is: "
                             (substring-no-properties (car kill-ring))))
    (deferred:$
      (deferred:next
        (lambda ()
          (chatgpt-query full-input)))
      (deferred:nextc it
        (lambda ()
          (insert chatgpt-response)))))

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
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")

  (global-org-modern-mode)

  (use-package! org-excalidraw)
  :config
  (setq org-excalidraw-directory "~/Notes/Excalidraw/")
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
          (shell-command (org-excalidraw--shell-cmd-to-svg filename))))))


  (use-package! edraw
    :load-path "~/.config/emacs/.local/straight/repos/el-easydraw/"
    :config
    (require 'edraw-org)
    (edraw-org-setup-default)
    (with-eval-after-load "ox"
      (require 'edraw-org)
      (edraw-org-setup-exporter)))

  )
