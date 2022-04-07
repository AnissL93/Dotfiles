;;; org.el -*- lexical-binding: t; -*-

(after! org
  (setq gtd_files (concat (getenv "HOME") "/Documents/RoamNotes/gtd/")
        org_notes (concat (getenv "HOME") "/Documents/RoamNotes/")
        work_org_notes (concat (getenv "HOME") "/Documents/RoamNotes/works/")
        bib_file (concat (getenv "HOME") "/Documents/RoamNotes/bibliography/ref.bib")
        org-directory org_notes
        deft-directory org_notes
        org-roam-directory org_notes
        org-agenda-files (list gtd_files)

        org-log-done-with-time t
        org-agenda-ndays 3
        org-agenda-start-day "+0d"

        org-journal-dir "~/Documents/RoamNotes/"
        org-journal-enable-agenda-integration t
        org-journal-file-format "%Y%m%d"
        org-journal-date-format "%A, %d/%m/%Y"
        )


  (when (equal (getenv "DIST") "work")
    ;; other agenda files
    (add-to-list 'org-agenda-files "~/Documents/RoamNotes/works/20220217102159-meetings.org")
    (add-to-list 'org-agenda-files "~/Documents/RoamNotes/works/20220214120016-tfu.org"))

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
            (todo "" ((org-agenda-overriding-header "Grouped")
                      (org-super-agenda-groups
                       '((:auto-group t)))))
            (todo "" ((org-agenda-overriding-header "Other")
                      (org-super-agenda-groups
                       '((:auto-category t))                     )))
            ))
          )
        )


  ;;;;; latex format ;;;;;;
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

    (setq! orb-note-actions-interface 'hydra))

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
                   :kill-buffer t)
                 )
    ;;; gtd
 SCHEDULED: <2022-04-07 Thu>
    (add-to-list 'org-capture-templates
                 '("i" "Inbox" entry
                   (file+headline "~/Documents/RoamNotes/gtd/inbox.org" "Inbox")
                   "* TODO %?\n"
                   :empty-lines 1
                   :prepend t
                   :kill-buffer t))
    )

  (use-package! org-roam
    :preface
    (defvar org-roam-directory nil)
    :config
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
            :desc "open date" "d" #'org-roam-dailies-goto-date
            :desc "open today" "t" #'org-roam-dailies-goto-today
            :desc "open today" "n" #'org-roam-dailies-find-next-note
            :desc "open today" "p" #'org-roam-dailies-find-previous-nore
            :desc "open yesterday" "Y" #'org-roam-dailies-goto-yesterday
            :desc "open tomorrow" "T" #'org-roam-dailies-goto-tomorrow
            )))

    (map! :leader
          (:prefix-map ("m")
           (:prefix ("d" . "+data/deadline")
           :desc "org-timestamp-now" "n" #'aniss/set-timestamp-to-headline
            )))

    (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode))

  (use-package! org-roam-protocol
    :after org-protocol)

  (defun aniss/add-timestamp-to-headline ()
    "Set time stamp to current headline"
    (interactive)
    (evil-open-below 1)
    (insert-now-timestamp))

  (setq org-after-todo-state-change-hook 'aniss/add-timestamp-to-headline)


  )
