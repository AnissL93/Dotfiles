;;; md-modern-test.el --- ERT for md-modern -*- lexical-binding: t; -*-
;; Run: emacs --batch -L <markdown-mode dir> -L ~/.config/doom -l md-modern-test.el -f ert-run-tests-batch-and-exit

(require 'ert)
(require 'md-modern)

(defmacro md-modern-test--with (text &rest body)
  (declare (indent 1))
  `(with-temp-buffer
     (insert ,text)
     (markdown-mode)
     (md-modern-mode 1)
     (font-lock-ensure)
     ,@body))

(defun md-modern-test--disp (str &optional n)
  "Display property at the Nth (default 1) occurrence of STR."
  (goto-char (point-min))
  (search-forward str nil nil (or n 1))
  (get-text-property (match-beginning 0) 'display))

(ert-deftest md-modern-headings-and-faces ()
  (md-modern-test--with "# One\n\n## Two\n\n```bash\n# comment\n- code\n> code\n```\n"
    (should (equal (md-modern-test--disp "# One") "◉ "))
    (should (equal (md-modern-test--disp "## Two") "○ "))
    (should-not (md-modern-test--disp "# comment"))
    (should-not (md-modern-test--disp "- code"))
    (should-not (md-modern-test--disp "> code"))
    (should (assq 'markdown-header-face-1 face-remapping-alist))
    (md-modern-mode -1)
    (font-lock-ensure)
    (should-not (md-modern-test--disp "# One"))
    (should-not (assq 'markdown-header-face-1 face-remapping-alist))))

(ert-deftest md-modern-lists-checkboxes-quotes-rules ()
  (md-modern-test--with "- dash\n* star\n- [ ] todo\n- [x] done\n\n> quote\n\n---\n"
    (should (equal (md-modern-test--disp "- dash") "–"))
    (should (equal (md-modern-test--disp "* star") "•"))
    (should (equal (md-modern-test--disp "[ ]") "☐"))
    (should (equal (md-modern-test--disp "[x]") "☑"))
    (should (equal (md-modern-test--disp "> quote") "▌"))
    (should (equal (car (md-modern-test--disp "---")) 'space))))

(ert-deftest md-modern-with-hidden-markup ()
  "markdown-hide-markup hides \"# \" with display \"\"; the glyph must still show."
  (let ((markdown-hide-markup t))
    (md-modern-test--with "# One\n\nsome **bold** text\n"
      (should (equal (md-modern-test--disp "# One") "◉ "))
      (should (eq (get-text-property (progn (goto-char (point-min)) (search-forward "**") (match-beginning 0)) 'invisible)
                  'markdown-markup)))))

;;; md-modern-test.el ends here
