;;; ../Projects/Dotfiles/doom-emacs/input.el -*- lexical-binding: t; -*-

;; macOS: 离开 insert（Esc）切到英文，再进 insert 恢复之前的输入法。依赖 macism。
(when (and (eq system-type 'darwin) (executable-find "macism"))
  (defvar my/im-english "com.apple.keylayout.ABC")
  (defvar my/im-last nil "上次 insert 模式下的输入法")

  (defun my/im-set (id) (call-process "macism" nil 0 nil id)) ; 异步，不卡 Esc

  (add-hook 'evil-insert-state-exit-hook
            (lambda ()
              (setq my/im-last (car (process-lines "macism")))
              (unless (equal my/im-last my/im-english) (my/im-set my/im-english))))

  (add-hook 'evil-insert-state-entry-hook
            (lambda ()
              (when (and my/im-last (not (equal my/im-last my/im-english)))
                (my/im-set my/im-last)))))


(when (string-equal system-type "gnu/linux")

  (setq cur-input-method nil)

  ;; 1: en, 2: ch
  (defun get-cur-input-method ()
    (setq cur-input-method (string-to-number (shell-command-to-string "fcitx-remote"))))

  (defun set-input-method-to-en ()
    (shell-command (format "fcitx-remote -c")))

  (defun set-input-method-to-ch ()
    (shell-command (format "fcitx-remote -o")))

  (defun meow-insert-exit-hook-func ()
    (get-cur-input-method)
    (set-input-method-to-en))

  (defun meow-insert-enter-hook-func ()
    (if (eq cur-input-method 1)
        (set-input-method-to-en)
      (set-input-method-to-ch)))

  (setq meow-insert-exit-hook 'meow-insert-exit-hook-func)
  (setq meow-insert-enter-hook 'meow-insert-enter-hook-func))
