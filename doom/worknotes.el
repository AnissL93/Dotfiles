;;; worknotes.el -*- lexical-binding: t; -*-
;; Doom side of the Obsidian vault (/srv/sync/WorkNotes, see its README.md).
;; Plain markdown, no new packages:
;;   Tasks      -> wn-agenda / wn-dashboard / wn-kanban + task editing
;;   Dataview   -> frontmatter tables in wn-dashboard
;;   QuickAdd   -> wn-new (template + {{VALUE:x}} prompts + target folder)
;;   Templates / Daily Notes / Quick Switcher / Backlinks / Properties
;;   Pomodoro   -> org-timer

(require 'cl-lib)

(defvar wn-dir "/srv/sync/WorkNotes/")

(defvar wn-template-folders
  '(("Project" . "01_Projects")
    ("Article" . "02_Sources/Articles")
    ("Book" . "02_Sources/Books/Notes")
    ("Video" . "02_Sources/Videos")
    ("Paper" . "02_Sources/Papers")
    ("Paper_detailed" . "02_Sources/Papers")
    ("GitHub Repo" . "02_Sources/Repositories") ("Concept" . "03_Concepts/Concepts")
    ("Entity" . "04_Entities") ("People" . "04_Entities/People")
    ("Experiment" . "05_Experiments") ("Idea" . "06_Ideas") ("Writing" . "07_Writing")
    ("How-to" . "09_Resources/How-to") ("Troubleshooting" . "09_Resources/TroubleShoot")
    ("Company Research" . "10_Business") ("Market Research" . "10_Business/Market"))
  "Template name -> default folder for `wn-new' (mirrors the QuickAdd scripts).")

(defun wn--in-vault-p ()
  (and buffer-file-name (file-in-directory-p buffer-file-name wn-dir)))

(defun wn--files (&optional regexp)
  "All vault files matching REGEXP (default .md), skipping dot-dirs."
  (directory-files-recursively wn-dir (or regexp "\\.md\\'") nil
                               (lambda (d) (not (string-prefix-p "." (file-name-nondirectory d))))))

(defun wn--rel (f) (file-relative-name f wn-dir))
(defun wn--day (&optional n) (format-time-string "%F" (time-add nil (days-to-time (or n 0)))))

;;; Links / switcher / search / backlinks ──────────────────────────────

(defun wn--resolve-link (name)
  "Obsidian-style [[NAME]]: vault-relative path or unique basename, anywhere in the vault."
  (when (wn--in-vault-p)
    (let* ((name (replace-regexp-in-string "#.*" "" name))
           (name (if (file-name-extension name) name (concat name ".md"))))
      (if (file-exists-p (expand-file-name name wn-dir))
          (expand-file-name name wn-dir)
        (cl-find (file-name-nondirectory name) (wn--files ".")
                 :key #'file-name-nondirectory :test #'string=)))))

(defun wn--link-at-point ()
  "Target of the [[target|alias]] / ![[target]] under point."
  (save-excursion
    (let ((pt (point)) (eol (line-end-position)))
      (beginning-of-line)
      (cl-loop while (re-search-forward "\\[\\[\\([^]|]+\\)\\(?:|[^]]*\\)?\\]\\]" eol t)
               when (<= (match-beginning 0) pt (match-end 0)) return (match-string 1)))))

(defun wn-follow-link ()
  "Follow the wiki link at point (creating the note at vault root if missing), else RET."
  (interactive)
  (if-let ((name (wn--link-at-point)))
      (find-file (or (wn--resolve-link name) (expand-file-name (concat name ".md") wn-dir)))
    (if (and (derived-mode-p 'markdown-mode) (markdown-link-p))
        (markdown-follow-thing-at-point nil)
      (call-interactively #'evil-ret))))

(add-hook 'find-file-hook
          (defun wn--setup-h ()
            (when (wn--in-vault-p)
              (evil-local-set-key 'normal (kbd "RET") #'wn-follow-link)
              (add-hook 'before-save-hook #'wn--touch-updated nil t))))

;;; Display ──────────────────────────────────────────────────────────

(after! markdown-mode
  (advice-add 'markdown-convert-wiki-link-to-filename :before-until #'wn--resolve-link) ; gf, C-c C-o
  (custom-set-faces!
    '(markdown-header-face-1 :height 1.5 :weight bold)
    '(markdown-header-face-2 :height 1.3 :weight bold)
    '(markdown-header-face-3 :height 1.15 :weight bold)))

(defface wn-done-face '((t :inherit shadow :strike-through t)) "Finished task text.")

;; Styled view for every markdown buffer (gfm-mode included); wiki links only in the vault.
(add-hook 'markdown-mode-hook
          (defun wn--markdown-h ()
            (when (wn--in-vault-p)
              (setq-local markdown-enable-wiki-links t
                          markdown-wiki-link-alias-first nil)) ; Obsidian: [[target|alias]]
            (setq-local markdown-fontify-code-blocks-natively t
                        markdown-hide-urls t)
            (markdown-toggle-markup-hiding 1) ; toggle back: SPC m t m
            (add-to-list (make-local-variable 'font-lock-extra-managed-props) 'display)
            (font-lock-add-keywords
             nil
             '(("^[ \t]*\\([-*] \\[ \\]\\)" 1 '(face markdown-gfm-checkbox-face display "☐"))
               ("^[ \t]*\\([-*] \\[/\\]\\)" 1 '(face warning display "◐"))
               ("^[ \t]*\\([-*] \\[-\\]\\)\\(.*\\)" (1 '(face shadow display "☒")) (2 'wn-done-face))
               ("^[ \t]*\\([-*] \\[[xX]\\]\\)\\(.*\\)" (1 '(face success display "☑")) (2 'wn-done-face)))
             'append)
            (font-lock-flush)))

(defun wn-find ()
  "Quick switcher."
  (interactive)
  (find-file (expand-file-name (completing-read "Note: " (mapcar #'wn--rel (wn--files))) wn-dir)))

(defun wn-insert-link ()
  (interactive)
  (insert "[[" (completing-read "Link: " (mapcar #'file-name-base (wn--files))) "]]"))

(defun wn-search ()
  (interactive)
  (consult-ripgrep wn-dir))

;;; Properties: keep `updated:' current (Dataview sorts on it) ─────────

(defun wn--touch-updated ()
  (save-excursion
    (goto-char (point-min))
    (when (and (looking-at-p "---\n")
               (re-search-forward "^updated:.*$" (save-excursion (forward-line 1) (search-forward "\n---" nil t)) t))
      (replace-match (concat "updated: " (wn--day)) t t))))

(defun wn--frontmatter (file)
  "Scalar `key: value' pairs of FILE's YAML frontmatter as an alist."
  (with-temp-buffer
    (insert-file-contents file nil 0 4000)
    (let (fm)
      (when (looking-at-p "---\n")
        (forward-line 1)
        (while (and (not (looking-at-p "---")) (not (eobp)))
          (when (looking-at "\\([A-Za-z_]+\\):[ \t]*\\(.*\\)$")
            (push (cons (match-string 1) (string-trim (match-string 2) "[\"' ]+" "[\"' ]+")) fm))
          (forward-line 1)))
      fm)))

;;; Templates / QuickAdd / Daily notes ─────────────────────────────────

(defun wn--moment (fmt)
  "Moment.js date FMT -> `format-time-string' output."
  (let ((case-fold-search nil))
    (format-time-string
     (replace-regexp-in-string
      "YYYY\\|dddd\\|ddd\\|MM\\|DD\\|HH\\|mm\\|ss"
      (lambda (m) (cdr (assoc m '(("YYYY" . "%Y") ("dddd" . "%A") ("ddd" . "%a") ("MM" . "%m")
                                  ("DD" . "%d") ("HH" . "%H") ("mm" . "%M") ("ss" . "%S")))))
      fmt t t))))

(defun wn--render (text title)
  "Fill Obsidian/QuickAdd placeholders in TEXT; prompt once per {{VALUE:x}}."
  (let ((case-fold-search t) (asked '()))
    (replace-regexp-in-string
     "{{\\(date\\|time\\|title\\|VALUE\\)\\(?::\\([^}]*\\)\\)?}}"
     (lambda (m)
       (let ((kind (downcase (match-string 1 m))) (arg (match-string 2 m)))
         (pcase kind
           ("date" (wn--moment (or arg "YYYY-MM-DD")))
           ("time" (wn--moment (or arg "HH:mm")))
           ("title" title)
           (_ (if (string= arg "title") title
                (or (cdr (assoc arg asked))
                    (cdar (push (cons arg (read-string (concat arg ": "))) asked))))))))
     text t t)))

(defun wn--template (name title)
  (wn--render (with-temp-buffer
                (insert-file-contents (expand-file-name (concat "Templates/" name ".md") wn-dir))
                (buffer-string))
              title))

(defun wn--read-template ()
  (completing-read "Template: "
                   (mapcar #'file-name-base (directory-files (expand-file-name "Templates" wn-dir) nil "\\.md\\'"))))

(defun wn--visit-new (file tmpl title)
  "Visit FILE; if it didn't exist yet, fill it from TMPL.
Replaces whatever Doom's file-templates inserted on creation."
  (let ((new (not (file-exists-p file))))
    (find-file file)
    (when new
      (erase-buffer)
      (insert (wn--template tmpl title)))))

(defun wn-new ()
  "QuickAdd: new note from template, filed into its folder."
  (interactive)
  (let* ((tmpl (wn--read-template))
         (title (read-string "Title: "))
         (dir (read-directory-name "Folder: " (expand-file-name (or (cdr (assoc tmpl wn-template-folders)) "00_Inbox") wn-dir)))
         (dir (if (y-or-n-p (format "Create folder %s/? " title))
                  (expand-file-name title dir)
                dir))
         (file (expand-file-name (concat title ".md") dir)))
    (make-directory dir t)
    (wn--visit-new file tmpl title)))

(defun wn-insert-template ()
  (interactive)
  (insert (wn--template (wn--read-template) (file-name-base (or buffer-file-name "")))))

(defun wn-daily ()
  "Open today's note: 11_Daily/YYYY/MM/YYYY-MM-DD.md."
  (interactive)
  (let ((file (expand-file-name (format-time-string "11_Daily/%Y/%m/%F.md") wn-dir)))
    (make-directory (file-name-directory file) t)
    (wn--visit-new file "Daily Note" (wn--day))))

;;; Tasks (Obsidian Tasks emoji format) ─────────────────────────────────

(cl-defstruct wn-task file line status text due sched start done prio)

(defun wn--emoji-date (emoji text)
  (when (string-match (concat emoji "️? *\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}\\)") text)
    (match-string 1 text)))

(defun wn--tasks ()
  "Every checkbox line in the vault (Templates excluded)."
  (let (tasks)
    (dolist (f (wn--files))
      (unless (string-prefix-p "Templates/" (wn--rel f))
        (with-temp-buffer
          (insert-file-contents f)
          (let ((line 1))
            (while (not (eobp))
              (when (looking-at "[ \t]*[-*] \\[\\(.\\)\\] +\\(.*[^ \t\n]\\)")
                (let ((txt (match-string 2)))
                  (push (make-wn-task
                         :file (wn--rel f) :line line :status (match-string 1) :text txt
                         :due (wn--emoji-date "📅" txt) :sched (wn--emoji-date "⏳" txt)
                         :start (wn--emoji-date "🛫" txt) :done (wn--emoji-date "✅" txt)
                         :prio (cond ((string-match-p "🔺" txt) 0) ((string-match-p "⏫" txt) 1)
                                     ((string-match-p "🔼" txt) 2) ((string-match-p "🔽" txt) 4)
                                     ((string-match-p "⏬" txt) 5) (t 3)))
                        tasks)))
              (forward-line 1) (cl-incf line))))))
    (nreverse tasks)))

(defun wn--open-p (tk) (member (wn-task-status tk) '(" " "/")))
(defun wn--dates (tk) (delq nil (list (wn-task-start tk) (wn-task-sched tk) (wn-task-due tk))))
(defun wn--happens (tk) (car (sort (wn--dates tk) #'string<)))
(defun wn--happens-on (tk day) (member day (wn--dates tk)))
(defun wn--p (tk) (number-to-string (wn-task-prio tk)))
(defun wn--in (tk &rest dirs) (cl-some (lambda (d) (string-prefix-p d (wn-task-file tk))) dirs))

;; Each section: (TITLE PREDICATE SORT-KEY [LIMIT]); sort key is a string, ascending.
(defun wn--agenda-sections ()
  (let ((today (wn--day)) (wk (wn--day 7)))
    `(("⚠️ Overdue"
       ,(lambda (tk) (and (wn--open-p tk) (wn-task-due tk) (string< (wn-task-due tk) today)))
       ,(lambda (tk) (concat (wn-task-due tk) (wn--p tk))))
      ("📅 Today"
       ,(lambda (tk) (and (wn--open-p tk) (wn--happens-on tk today)))
       ,(lambda (tk) (concat (wn--p tk) (or (wn-task-due tk) "9"))))
      ("⏭ Upcoming (7 days)"
       ,(lambda (tk) (let ((h (wn--happens tk)))
                       (and (wn--open-p tk) h (string< today h) (string< h wk))))
       ,(lambda (tk) (concat (wn--happens tk) (wn--p tk))))
      ("📌 Scheduled, no deadline"
       ,(lambda (tk) (and (wn--open-p tk) (wn-task-sched tk) (not (wn-task-due tk))))
       ,#'wn-task-sched)
      ("📥 Unscheduled"
       ,(lambda (tk) (and (wn--open-p tk) (not (wn--dates tk))))
       ,#'wn--p)
      ("🔬 Research"
       ,(lambda (tk) (and (wn--open-p tk) (wn--in tk "01_Projects" "02_" "05_Experiments")))
       ,(lambda (tk) (or (wn-task-due tk) "9")))
      ("💼 Business"
       ,(lambda (tk) (and (wn--open-p tk) (or (wn--in tk "10_Business")
                                              (string-match-p "#business" (wn-task-text tk)))))
       ,(lambda (tk) (or (wn-task-due tk) "9"))))))

(defun wn--kanban-sections ()
  (let ((wk-ago (wn--day -7)))
    `(("TODO" ,(lambda (tk) (equal (wn-task-status tk) " "))
       ,(lambda (tk) (concat (wn--p tk) (or (wn-task-due tk) "9"))))
      ("DOING" ,(lambda (tk) (equal (wn-task-status tk) "/"))
       ,(lambda (tk) (or (wn-task-due tk) "9")))
      ("DONE (7 days)" ,(lambda (tk) (and (member (wn-task-status tk) '("x" "X"))
                                          (wn-task-done tk) (not (string< (wn-task-done tk) wk-ago))))
       ;; ponytail: invert chars for "sort by done reverse"
       ,(lambda (tk) (apply #'string (mapcar (lambda (c) (- 200 c)) (wn-task-done tk))))
       30))))

(defun wn--insert-tasks (tasks title pred key &optional limit)
  (let ((hits (sort (cl-remove-if-not pred tasks) (lambda (a b) (string< (funcall key a) (funcall key b))))))
    (insert (format "\n## %s (%d)\n" title (length hits)))
    (dolist (tk (seq-take hits (or limit most-positive-fixnum)))
      (insert (format "%s:%d: %s%s\n" (wn-task-file tk) (wn-task-line tk)
                      (if (equal (wn-task-status tk) "/") "[/] " "") (wn-task-text tk))))))

;;; Dataview-style frontmatter tables ──────────────────────────────────

(defun wn--insert-table (title dirs pred cols &optional sort-field limit)
  "Notes under DIRS whose frontmatter satisfies PRED, showing COLS.
Sorted by SORT-FIELD descending, or by mtime when nil."
  (let* ((notes (cl-loop for f in (wn--files)
                         for fm = (and (cl-some (lambda (d) (string-prefix-p d (wn--rel f))) dirs)
                                       (list (wn--frontmatter f)))
                         when (and fm (funcall pred (car fm)))
                         collect (list f (car fm) (file-attribute-modification-time (file-attributes f)))))
         (notes (sort notes (lambda (a b)
                              (if sort-field
                                  (string> (or (cdr (assoc sort-field (nth 1 a))) "")
                                           (or (cdr (assoc sort-field (nth 1 b))) ""))
                                (time-less-p (nth 2 b) (nth 2 a)))))))
    (insert (format "\n## %s (%d)\n" title (length notes)))
    (dolist (n (seq-take notes (or limit most-positive-fixnum)))
      (insert (format "%s:1: %s%s\n" (wn--rel (car n)) (file-name-base (car n))
                      (mapconcat (lambda (c) (format "  │ %s" (or (cdr (assoc c (nth 1 n))) "")))
                                 cols ""))))))

;;; Views ──────────────────────────────────────────────────────────────

(defun wn--view (name fill)
  "Render a navigable (grep-mode) view; RET jumps, x done, / doing, gr refresh."
  (let ((buf (get-buffer-create (format "*WorkNotes %s*" name))))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert (format "# %s — %s\n" name (wn--day)))
        (funcall fill)
        (goto-char (point-min)))
      (setq default-directory wn-dir)
      (grep-mode)
      (setq-local revert-buffer-function (lambda (&rest _) (wn--view name fill)))
      (evil-local-set-key 'normal "x" #'wn-view-done)
      (evil-local-set-key 'normal "/" #'wn-view-doing)
      (evil-local-set-key 'normal "gr" #'revert-buffer))
    (pop-to-buffer-same-window buf)))

(defun wn-agenda ()
  (interactive)
  (wn--view "Agenda" (lambda () (let ((tasks (wn--tasks)))
                                  (pcase-dolist (s (wn--agenda-sections))
                                    (apply #'wn--insert-tasks tasks s))))))

(defun wn-kanban ()
  (interactive)
  (wn--view "Kanban" (lambda () (let ((tasks (wn--tasks)))
                                  (pcase-dolist (s (wn--kanban-sections))
                                    (apply #'wn--insert-tasks tasks s))))))

(defun wn-dashboard ()
  (interactive)
  (wn--view "Dashboard"
            (lambda ()
              (let ((tasks (wn--tasks)) (secs (wn--agenda-sections)))
                (apply #'wn--insert-tasks tasks (assoc "📅 Today" secs))
                (apply #'wn--insert-tasks tasks (assoc "⚠️ Overdue" secs))
                (apply #'wn--insert-tasks tasks (assoc "⏭ Upcoming (7 days)" secs))
                (apply #'wn--insert-tasks tasks (append (assoc "📥 Unscheduled" secs) '(15))))
              (wn--insert-table "Active Projects" '("01_Projects")
                                (lambda (fm) (equal (cdr (assoc "status" fm)) "active"))
                                '("area" "status" "updated") "updated")
              (wn--insert-table "Reading / Research Queue" '("02_" "10_Business")
                                (lambda (fm) (member (cdr (assoc "status" fm)) '("reading" "researching")))
                                '("type" "status" "topic") nil 15)
              (wn--insert-table "Recent Ideas" '("06_Ideas") #'always nil nil 10))))

(defun wn-backlinks ()
  "Notes linking to the current one."
  (interactive)
  (let* ((name (file-name-base buffer-file-name))
         (re (concat "\\[\\[\\([^]|#]*/\\)?" (regexp-quote name) "\\([]|#]\\|\\.md\\)")))
    (wn--view (concat "Backlinks: " name)
              (lambda ()
                (insert "\n"
                        (mapconcat
                         #'identity
                         (cl-loop for f in (wn--files)
                                  nconc (with-temp-buffer
                                          (insert-file-contents f)
                                          (cl-loop while (re-search-forward re nil t)
                                                   collect (format "%s:%d: %s" (wn--rel f) (line-number-at-pos)
                                                                   (string-trim (thing-at-point 'line t)))
                                                   do (forward-line 1))))
                         "\n")
                        "\n")))))

;;; Task editing (in notes and from views) ─────────────────────────────

(defun wn-task-set (status)
  "Set the checkbox on this line to STATUS; add/remove the ✅ done date like Tasks does."
  (save-excursion
    (beginning-of-line)
    (unless (re-search-forward "^[ \t]*[-*] \\[\\(.\\)\\]" (line-end-position) t)
      (user-error "No task on this line"))
    (let ((new (if (and (equal status "x") (member (match-string 1) '("x" "X"))) " " status)))
      (replace-match new t t nil 1)
      (end-of-line)
      (when (re-search-backward " *✅ *[0-9-]\\{10\\}" (line-beginning-position) t)
        (replace-match ""))
      (end-of-line)
      (delete-horizontal-space)
      (when (equal new "x")
        (end-of-line)
        (insert " ✅ " (wn--day))))))

(defun wn-mark-done () (interactive) (wn-task-set "x"))
(defun wn-mark-doing () (interactive) (wn-task-set "/"))

(defun wn-task-date (emoji)
  "Set EMOJI date (📅 due, ⏳ scheduled, 🛫 start) on this task line."
  (interactive (list (cdr (assoc (completing-read "Date: " '("📅 due" "⏳ scheduled" "🛫 start"))
                                 '(("📅 due" . "📅") ("⏳ scheduled" . "⏳") ("🛫 start" . "🛫"))))))
  (let ((date (org-read-date)))
    (save-excursion
      (end-of-line)
      (if (re-search-backward (concat emoji " *[0-9-]\\{10\\}") (line-beginning-position) t)
          (replace-match (concat emoji " " date))
        (end-of-line)
        (insert " " emoji " " date)))))

(defun wn--view-act (status)
  (compile-goto-error)
  (wn-task-set status)
  (save-buffer)
  (other-window -1)
  (revert-buffer))

(defun wn-view-done () (interactive) (save-selected-window (wn--view-act "x")))
(defun wn-view-doing () (interactive) (save-selected-window (wn--view-act "/")))

;;; Pomodoro ───────────────────────────────────────────────────────────

(setq org-timer-default-timer "25")

;;; Keys: SPC n w … ────────────────────────────────────────────────────

(map! :leader
      (:prefix-map ("n w" . "WorkNotes")
       :desc "Daily note"        "d" #'wn-daily
       :desc "New (QuickAdd)"    "n" #'wn-new
       :desc "Insert template"   "i" #'wn-insert-template
       :desc "Find note"         "f" #'wn-find
       :desc "Search vault"      "s" #'wn-search
       :desc "Insert [[link]]"   "l" #'wn-insert-link
       :desc "Backlinks"         "b" #'wn-backlinks
       :desc "Agenda"            "a" #'wn-agenda
       :desc "Dashboard"         "D" #'wn-dashboard
       :desc "Kanban"            "k" #'wn-kanban
       :desc "Task done"         "x" #'wn-mark-done
       :desc "Task doing"        "/" #'wn-mark-doing
       :desc "Task date"         "t" #'wn-task-date
       :desc "Pomodoro (25m)"    "p" #'org-timer-set-timer))
