;;; ../Projects/Dotfiles/doom-emacs/meow-edit-config.el -*- lexical-binding: t; -*-
(use-package! meow
  :config
  (meow-setup-indicator)
  (setq meow--kbd-undo "C-_")
  (setq meow--kbd-forward-slurp "C-c e s")
  (setq meow--kbd-backward-slurp "C-c e S")
  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-overwrite-define-key
     '("j" . meow-next)
     '("k" . meow-prev))
    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
     '("j" . "H-j")
     '("k" . "H-k")
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("o" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-kill)
     '("w" . meow-next-word)
     '("W" . meow-next-symbol)
     '("&" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("O" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("%" . meow-block)
     '("M" . meow-to-block)
     '("p" . meow-yank)
     '("P" . meow-replace)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . negative-argument)
     ;; maybe change this ??
     '("U" . undo-redo)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("s" . meow-visit)
     '("S" . meow-forward-slurp)
     ;; '("M" . meow-backward-slurp)
     '("e" . meow-mark-word)
     '("E" . meow-mark-symbol)
     '("x" . meow-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     ;; '("Z" . meow-pop-selection)
     '("'" . repeat)
     '("(" . scroll-down)
     '(")" . scroll-up)
     '("<escape>" . ignore)
     ;; goto begin/end of buffer
     '("<" . beginning-of-buffer)
     '(">" . end-of-buffer)

     ;; avy-goto
     '("f" . avy-goto-word-1)
     '("F" . avy-goto-char-2)

     ;; tiny
     '("_" . tiny-expand)

     ;; window manage
     '("$" . save-buffer)
     '("v" . split-window-right)
     '("V" . split-window-below)
     '("C" . other-window)
     '("*" . +format/buffer)
     '("z" . recenter)

     ;; buffer manage
     '("X" . kill-current-buffer)
     '("#" . consult-buffer)
     '("/" . +default/search-buffer)))
  (meow-setup)
  (setq meow-use-clipboard t)
  )
