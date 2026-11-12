;;; md-modern.el --- org-modern look for markdown-mode -*- lexical-binding: t; -*-

;; Makes markdown buffers look like org-modern org buffers: heading glyphs,
;; list bullets, checkboxes, quote bars, full-width rules, and org's faces.
;; It reuses org-modern's settings when loaded, so both stay in sync.
;; Only the display changes; the file text is untouched.

;;; Code:

(require 'markdown-mode)
(require 'org-faces)
(require 'face-remap)
(require 'cl-lib)

(defvar org-modern-replace-stars)
(defvar org-modern-list)

(defgroup md-modern nil "Org-modern look for markdown." :group 'markdown)

(defcustom md-modern-checkboxes '((?\s . "☐") (?x . "☑") (?X . "☑"))
  "Display strings for GFM checkboxes, keyed by the char inside [ ]."
  :type '(alist :key-type character :value-type string))

(defconst md-modern--face-remaps
  '((markdown-header-face-1 . org-level-1) (markdown-header-face-2 . org-level-2)
    (markdown-header-face-3 . org-level-3) (markdown-header-face-4 . org-level-4)
    (markdown-header-face-5 . org-level-5) (markdown-header-face-6 . org-level-6)
    (markdown-code-face . org-block) (markdown-inline-code-face . org-code)
    (markdown-blockquote-face . org-quote) (markdown-link-face . org-link)
    (markdown-table-face . org-table))
  "Markdown faces shown with the matching org face.")

(defvar-local md-modern--cookies nil "Face-remap cookies to undo on disable.")

(defun md-modern--stars ()
  (if (and (boundp 'org-modern-replace-stars) (stringp org-modern-replace-stars))
      org-modern-replace-stars
    "◉○✸✿"))

(defun md-modern--bullet (char)
  (or (alist-get char (if (boundp 'org-modern-list) org-modern-list
                        '((?+ . "◦") (?- . "–") (?* . "•"))))
      (string char)))

(defun md-modern--has (pos prop)
  "Non-nil when markdown-mode's syntax pass marked POS with PROP.
Code blocks are excluded; this does not depend on face settings."
  (and (get-text-property pos prop)
       (not (or (get-text-property pos 'markdown-gfm-code)
                (get-text-property pos 'markdown-fenced-code)
                (get-text-property pos 'markdown-pre)))))

(defconst md-modern--rules
  `(("^\\(#+\\)[ \t]" . ,(lambda ()
                           (let ((b (match-beginning 1)) (n (- (match-end 1) (match-beginning 1))))
                             (when (md-modern--has b 'markdown-heading)
                               (let ((stars (md-modern--stars)))
                                 ;; Cover "#… " incl. the space: markdown-hide-markup blanks it.
                                 (add-text-properties
                                  b (match-end 0)
                                  `(display ,(string (aref stars (mod (1- n) (length stars))) ?\s)
                                            face ,(intern (format "markdown-header-face-%d" (min n 6))))))))))
    ("^[ \t]*\\([-*+]\\)[ \t]+\\(\\[\\([ xX]\\)\\]\\)?" .
     ,(lambda ()
        (when (md-modern--has (match-beginning 1) 'markdown-list-item)
          (put-text-property (match-beginning 1) (match-end 1)
                             'display (md-modern--bullet (char-after (match-beginning 1))))
          (when-let* ((box (match-beginning 2)))
            (put-text-property box (match-end 2) 'display
                               (alist-get (char-after (match-beginning 3)) md-modern-checkboxes))))))
    ("^[ \t]*\\(>\\)" . ,(lambda ()
                           (when (md-modern--has (match-beginning 1) 'markdown-blockquote)
                             (put-text-property (match-beginning 1) (match-end 1) 'display "▌"))))
    ("^[-*_ \t]\\{3,\\}$" . ,(lambda ()
                               (when (md-modern--has (match-beginning 0) 'markdown-hr)
                                 (add-text-properties
                                  (match-beginning 0) (match-end 0)
                                  '(display (space :align-to right)
                                            face (:inherit markdown-hr-face :strike-through t)))))))
  "(REGEXP . FN) pairs; FN decorates the current match.")

(defun md-modern--fontify (limit)
  "Font-lock matcher: decorate everything up to LIMIT, then report no match."
  (let ((start (point)))
    (pcase-dolist (`(,re . ,fn) md-modern--rules)
      (goto-char start)
      (while (re-search-forward re limit t)
        (save-excursion (save-match-data (funcall fn))))))
  nil)

(defconst md-modern--keywords '((md-modern--fontify)))

;;;###autoload
(define-minor-mode md-modern-mode
  "Show markdown with the org-modern look."
  :lighter nil
  (mapc #'face-remap-remove-relative md-modern--cookies)
  (setq md-modern--cookies nil)
  (font-lock-remove-keywords nil md-modern--keywords)
  (when md-modern-mode
    (setq md-modern--cookies
          (mapcar (lambda (r) (face-remap-add-relative (car r) (cdr r))) md-modern--face-remaps))
    (setq-local font-lock-extra-managed-props
                (cl-adjoin 'display font-lock-extra-managed-props))
    ;; Append: runs after markdown-mode's keywords so our faces win.
    (font-lock-add-keywords nil md-modern--keywords 'append))
  (font-lock-flush))

(provide 'md-modern)
;;; md-modern.el ends here
