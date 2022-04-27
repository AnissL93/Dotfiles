;;; org.el -*- lexical-binding: t; -*-
(after! org
  (setq org_notes (concat (getenv "HOME") "/Documents/RoamNotes/")
        work_org_notes (concat (getenv "HOME") "/Documents/RoamNotes/works/")
        ;; bib_file (concat (getenv "HOME") "/Documents/RoamNotes/bibliography/ref.bib")
        bib_file (concat (getenv "HOME") "/Projects/ustcthesis/bib/ref.bib")
        org-directory org_notes
        deft-directory org_notes
        org-roam-directory org_notes
        org-agenda-files (append (list org_notes) (list work_org_notes))

        org-log-done-with-time t
        org-agenda-ndays 3
        org-agenda-start-day "+0d"

        ;; org-journal-dir "~/Documents/RoamNotes/"
        ;; org-journal-enable-agenda-integration t
        ;; org-journal-file-format "%Y%m%d"
        ;; org-journal-date-format "%A, %d/%m/%Y"
        +org-capture-journal-file (concat org_notes "journal.org"))

  (setq reftex-default-bibliography '("~/Documents/RoamNotes/bibliography/ref.bib"))

  (defun auii/open-bib-file ()
    (interactive)
    (find-file (car reftex-default-bibliography)))


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
     org-noter-notes-window-location 'horizontal-split
     ;; Please stop opening frames
     org-noter-always-create-frame nil
     ;; I want to see the whole file
     org-noter-hide-other nil
     ;; Everything is relative to the main notes file
     org-noter-notes-search-path (list org_notes)
     )
    )

  ;; Actually start using templates
  (after! org-capture
    (require 'org-contacts)
    (require 'org-protocol)
    (setq org-protocol-default-template-key nil)
    (setq org-html-validation-link nil)
    (setq enable-local-variables :safe)

    (setq org-contacts-files '("~/Documents/RoamNotes/20220304154932-contacts.org"))
    ;; Firefox and Chrome
    (setq org-capture-templates
          '(("c" "Contact" entry
             (file+headline "~/Documents/RoamNotes/20220304154932-contacts.org" "Cambricon")
             "* %(org-contacts-template-name)\n :PROPERTIES:\n :BIRTHDAY: %^{yyyy-mm-dd}\n :EMAIL: %(org-contacts-template-email)\n :NOTE: %^{NOTE}\n :END:"
             :empty-lines 1
             :prepend t
             :kill-buffer t)
            ("i" "Inbox" entry
             (file+headline "~/Documents/RoamNotes/gtd/inbox.org" "Inbox")
             "* TODO %?\n"
             :empty-lines 1
             :prepend t
             :kill-buffer t)

            ("b" "Protocol" entry
             (file+headline "~/Documents/RoamNotes/20220213034655-inbox.org" "WebCapture")
             "* %:description\nSource: %t\n[[%:link][%:description]]\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")

            ;; link for linkz
            ("o" "Link capture" entry
             (file+headline "~/Documents/RoamNotes/org-linkz/Linkz.org" "INBOX")
             "* %a %U"
             :immediate-finish t)
            )))

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

            ("t" "todo" entry
             "* %?\n %a"
             :target
             (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
             :unnarrowed t)
            ))


    (setq org-roam-directory (expand-file-name (or org-roam-directory org_notes)
                                               org-directory)
          org-roam-verbose nil  ; https://youtu.be/fn4jIlFwuLU
          org-roam-buffer-no-delete-other-windows t ; make org-roam buffer sticky
          org-roam-completion-system 'default)

    (map! :leader
          (:prefix-map ("m")
           (:prefix ("d" . "+data/deadline")
            :desc "org-timestamp-now" "N" #'auii/set-timestamp-to-headline
            :desc "org-timestamp-now" "n" #'insert-now-timestamp
            )))

    (add-hook 'org-roam-buffer-prepare-hook #'hide-mode-line-mode))

  (use-package! org-roam-protocol
    :after org-protocol)

  (defun auii/add-timestamp-to-headline ()
    "Set time stamp to current headline"
    (interactive)
    (evil-open-below 1)
    (insert-now-timestamp))

  (setq org-after-todo-state-change-hook nil)

  (defun insert-now-timestamp()
    "Insert org mode timestamp at point with current date and time."
    (interactive)
    (org-insert-time-stamp (current-time) t))

  ;;; jira
  (when (equal "work" (getenv "DIST"))
    (use-package! org-jira
      :init
      (setq jiralib-url "http://jira.cambricon.com")
      (setq org-jira-working-dir "/data/Projects/Jira")
      (setq org-jira-custom-jqls
            '(
              ;; (:jql
              ;; "(project = MAG OR project = Inference_Platform) AND issuetype = Bug AND status in (Open, \"In Progress\", Reopened, 已确认, 暂不处理, 暂停) AND component in (tfu, ngpf, e2e_perf) ORDER BY priority DESC, updated DESC"
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
              ;; (:jql
              ;;  ;; "(project = MAG OR project = Inference_Platform) AND issuetype = Bug AND component in (tfu, ngpf, e2e_perf) AND project = MAG AND fixVersion = mm_v0.10.0 ORDER BY status ASC, priority DESC, updated DESC"
              ;;  "(project = MAG OR project = Inference_Platform) AND issuetype = Bug AND component in (tfu, ngpf, e2e_perf) AND project = MAG AND fixVersion = mm_v0.10.0 AND status = Closed ORDER BY status ASC, priority DESC, updated DESC"
              ;;  :filename "tfu-v0.10-closed-bugs")
             ;; (:jql
              ;;  "labels = tfu-compile"
              ;;  :filename "tfu-compile")
              (:jql "labels = tfu-perf"
               :filename "tfu-perf")
              (:jql "labels = tfu-precision"
               :filename "tfu-precision")
              (:jql "labels = tfu-log"
               :filename "tfu-log")
              )
            ))

    ;; (use-package! ox-hugo
    ;;   :config
    ;;   (setq org-hugo-base-dir "/data/DataBase/hugo")
    ;;   :after ox)

    (with-eval-after-load 'ox
      (require 'ox-pandoc)
      (require 'ox-jira)
      (require 'ox-wk)))


  (defun auii/archive-link-and-open ()
    (interactive)
    (auii/unset_proxy)
    (org-set-property "URL" (x-get-clipboard))
    (org-board-archive)
    (auii/set_proxy)
    (org-board-open))

  (use-package! org-board
    :config
    (map! :leader
          (:prefix-map ("m")
           (:prefix ("l" . "+link")
            :desc "org-board-archive" "a" #'auii/archive-link-and-open))))

  )
