;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
                                        ;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
                                        ;(package! another-package
                                        ;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
                                        ;(package! this-package
                                        ;  :recipe (:host github :repo "username/repo"
                                        ;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
                                        ;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
                                        ;(package! builtin-package :recipe (:nonrecursive t))
                                        ;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
                                        ;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
                                        ;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
                                        ;(unpin! pinned-package)
;; ...or multiple packages
                                        ;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
                                        ;(unpin! t)


(package! gitconfig-mode
  :recipe (:host github :repo "magit/git-modes" :files ("gitconfig-mode.el")))
(package! gitignore-mode
  :recipe (:host github :repo "magit/git-modes" :files ("gitignore-mode.el")))

;; (package! mu4e)

;; themes
(package! moe-theme)
(package! jazz-theme)
(package! melancholy-theme)
(package! alect-themes)
(package! gotham-theme)
(package! darktooth-theme)
(package! color-theme-modern)
(package! avk-emacs-themes)
(package! sublime-themes)
(package! humanoid-themes)
(package! kaolin-themes)
(package! xresources-theme
  :recipe (:host github :repo "martenlienen/xresources-theme"))
(package! nimbus-theme)
(package! apropospriate-theme)

;; tools
(package! rime
  :recipe
  (:host github :repo "DogLooksGood/emacs-rime" :files ("*.el" "Makefile" "lib.c")))

(package! org-ref
  :recipe (:host github :repo "jkitchin/org-ref"))
;; (package! org-noter
;;   :recipe (:host github :repo "weirdNox/org-noter"))
(package! ivy-bibtex)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))

(package! org-board)
(package! nov)
(package! justify-kp
  :recipe
  (:host github :repo "Fuco1/justify-kp"))

(package! ledger-mode
  :recipe (:host github :repo "ledger/ledger-mode"))

(package! ox-pandoc)
(package! org-board)

(package! scihub
  :recipe (:host github :repo "emacs-pe/scihub.el"))

(package! beacon)

(package! org-jira)
;; (package! ox-hugo)
(package! org-super-agenda)
(package! ox-wk)
(package! ox-jira)
(package! arduino-mode)


(package! sdcv
  :recipe (:host github :repo "manateelazycat/sdcv"))

(package! cnfonts)

;; https://github.com/alphapapa/org-protocol-capture-html#org-protocol-instructions
(package! org-protocol-capture-html
  :recipe (:host github :repo "alphapapa/org-protocol-capture-html"))

(package! command-log-mode)

(package! el-easydraw
  :recipe (:host github :repo "misohena/el-easydraw"))

(package! tiny
  :recipe (:host github :repo "abo-abo/tiny"))
