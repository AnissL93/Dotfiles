;;; ../Projects/Dotfiles/doom-emacs/input.el -*- lexical-binding: t; -*-

(when (string-equal system-type "darwin")
  (setq input-switch-method0 "com.apple.keylayout.ABC")
  (setq input-switch-method1 "com.sogou.inputmethod.sogou.pinyin")
  (setq input-switch-is-on nil)

  (setq input-methods-in-insert-mode nil)

  ;; 通过运行命令切换输入法
  (defun input-switch-use-method (method)
    (when input-switch-is-on
      (shell-command (replace-regexp-in-string "method" method "im-select method"))))

  (defun store-current-input-method ()
    (setq input-methods-in-insert-mode (shell-command-to-string "im-select")))

  ;; 开启或关闭输入法切换
  (defun input-switch-enable () (interactive) (setq input-switch-is-on t))
  (defun input-switch-disable () (interactive) (setq input-switch-is-on nil))

  ;; 进入insert mode, 换成之前的input method
  (add-hook 'evil-insert-state-entry-hook
            (lambda ()
              (when (not (equal input-methods-in-insert-mode nil))
                (input-switch-use-method input-methods-in-insert-mode))))

  ;; 退出insert mode切换第一输入法（英文）
  (add-hook 'evil-insert-state-exit-hook
            (lambda ()
              (store-current-input-method)
              (input-switch-use-method input-switch-method0)))

  (input-switch-enable))


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
