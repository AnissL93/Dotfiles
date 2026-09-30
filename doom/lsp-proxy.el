;;; lsp-proxy.el -*- lexical-binding: t; -*-
;;
;; lsp-proxy is a Rust-based LSP client (an alternative to eglot/lsp-mode).
;; It is used here for Python, Go, Rust and TypeScript/JavaScript.
;;
;; eglot (`:tools (lsp +eglot)') is still used for C/C++ and LaTeX.  The
;; `+lsp' flag was removed from the python/go/rust modules in init.el, and
;; `rust' carries an explicit `-lsp' (Doom's rust module tests for `-lsp',
;; not for the absence of `+lsp'), so the two clients never share a buffer.
;;
;; Binaries:
;;   local  binary : ~/.config/emacs/lsp-proxy/emacs-lsp-proxy
;;   local  config : $DOOMDIR/languages.toml  (version-controlled)
;;   remote binary : ~/.emacs.d/lsp-proxy/emacs-lsp-proxy
;;   remote config : ~/.emacs.d/lsp-proxy/languages.toml  (per host)
;;
;; Useful commands:
;;   M-x lsp-proxy-open-config-file         edit the local languages.toml
;;   M-x lsp-proxy-remote-open-config-file  edit a remote host's languages.toml
;;   M-x lsp-proxy-remote-deploy            push the binary to a remote host
;;   M-x lsp-proxy-restart / lsp-proxy-open-log-file

;; The lsp-proxy process spawns the language servers itself, so it inherits
;; Emacs' PATH.  `exec-path-from-shell' only runs under `daemonp' here, so make
;; sure the toolchain directories are present either way.
(let ((dirs (append (list (expand-file-name "~/.local/bin")
                          (expand-file-name "~/.cargo/bin")
                          (expand-file-name "~/go/bin"))
                    ;; whichever node nvm currently has installed
                    (file-expand-wildcards
                     (expand-file-name "~/.nvm/versions/node/*/bin")))))
  (dolist (dir dirs)
    (when (file-directory-p dir)
      (add-to-list 'exec-path dir)
      (unless (member dir (split-string (or (getenv "PATH") "") path-separator))
        (setenv "PATH" (concat dir path-separator (getenv "PATH")))))))

(use-package! lsp-proxy
  :init
  ;; NOTE: Doom rebinds `user-emacs-directory' to ~/.config/emacs/.local/cache/,
  ;; so lsp-proxy's defaults would put both the binary and languages.toml in a
  ;; cache directory.  Pin both to stable locations instead.
  (setq lsp-proxy-install-dir (expand-file-name "lsp-proxy/" doom-emacs-dir)
        ;; languages.toml lives in the dotfiles repo, so it is version-controlled.
        lsp-proxy-user-languages-config (expand-file-name "languages.toml" doom-user-dir))

  ;; Use the managed native binary rather than whatever `emacs-lsp-proxy'
  ;; resolves to on PATH (npm installs a node shim by that name).
  (let ((bin (expand-file-name "emacs-lsp-proxy" lsp-proxy-install-dir)))
    (when (file-executable-p bin)
      (setq lsp-proxy-server-path bin)))

  ;; --- remote (TRAMP) development -----------------------------------------
  ;; Keep everything under ~/.emacs.d on the remote host.  languages.toml for
  ;; each host lives next to this binary.
  ;;
  ;; Works over both TRAMP methods, and lsp-proxy recognises each one's paths
  ;; (see `lsp-proxy-remote--connection-key-from-buffer'):
  ;;
  ;;   /rpc:gcloud_tdx:/path   tramp-rpc -- preferred.  Binary MessagePack-RPC,
  ;;                           no remote shell parsing, much faster file ops.
  ;;   /ssh:gcloud_tdx:/path   stock TRAMP -- works, but parses a shell prompt.
  ;;
  ;; Note the LSP traffic itself always rides lsp-proxy's own SSH connection to
  ;; `emacs-lsp-proxy --remote-server'; the TRAMP method only governs file I/O.
  ;; `lsp-proxy-remote-open-config-file' hardcodes an /ssh: prefix, so the
  ;; remote shell still has to be TRAMP-safe even when editing over /rpc:.
  (setq lsp-proxy-remote-binary-path "~/.emacs.d/lsp-proxy/emacs-lsp-proxy"
        ;; 'manual: prompt before uploading a binary to a host.  Set to 'auto
        ;; to have lsp-proxy deploy itself on first use of a new host.
        lsp-proxy-remote-deploy-mode 'manual)

  :hook ((python-mode          . lsp-proxy-mode)
         (python-ts-mode       . lsp-proxy-mode)
         (go-mode              . lsp-proxy-mode)
         (go-ts-mode           . lsp-proxy-mode)
         (rust-mode            . lsp-proxy-mode)
         (rust-ts-mode         . lsp-proxy-mode)
         (rustic-mode          . lsp-proxy-mode)
         (typescript-mode      . lsp-proxy-mode)
         (typescript-ts-mode   . lsp-proxy-mode)
         (tsx-ts-mode          . lsp-proxy-mode)
         (js-mode              . lsp-proxy-mode)
         (js-ts-mode           . lsp-proxy-mode))
  :config
  ;; `lsp-proxy-guess-language' derives the language from the first
  ;; dash-separated word of the major-mode name, so `rustic-mode' yields
  ;; "rustic" and `js-mode' yields "js" -- neither matches the "rust" /
  ;; "javascript" entries in languages.toml, and no server is started.
  ;; Doom defaults to `rustic-mode' for Rust, so this mapping is required.
  (defvar +lsp-proxy-language-overrides
    '((rustic-mode . "rust")
      (js-mode     . "javascript")
      (js-ts-mode  . "javascript")
      (js2-mode    . "javascript")
      (rjsx-mode   . "javascript"))
    "Alist of `major-mode' to lsp-proxy language name.
Consulted before `lsp-proxy-guess-language' falls back to its own guess.")

  (defadvice! +lsp-proxy-guess-language-a (fn &rest args)
    "Map major-modes whose name doesn't match their languages.toml entry."
    :around #'lsp-proxy-guess-language
    (or (alist-get major-mode +lsp-proxy-language-overrides)
        (apply fn args)))

  ;; Route Doom's `gd' / `gr' / `K' etc. through lsp-proxy.
  (set-lookup-handlers! 'lsp-proxy-mode
    :definition      '(lsp-proxy-find-definition :async t)
    :references      '(lsp-proxy-find-references :async t)
    :implementations '(lsp-proxy-find-implementations :async t)
    :type-definition '(lsp-proxy-find-type-definition :async t)
    :documentation   '(lsp-proxy-describe-thing-at-point :async t))

  ;; Mirror Doom's usual `SPC c' LSP bindings.
  (map! :map lsp-proxy-mode-map
        :localleader
        "a" #'lsp-proxy-execute-code-action
        "r" #'lsp-proxy-rename
        "f" #'lsp-proxy-format-buffer
        "R" #'lsp-proxy-restart
        "l" #'lsp-proxy-open-log-file
        "c" #'lsp-proxy-open-config-file))
