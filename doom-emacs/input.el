;;; ../Projects/Dotfiles/doom-emacs/input.el -*- lexical-binding: t; -*-

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

(input-switch-enable)
