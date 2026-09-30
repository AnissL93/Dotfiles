;;; ../../System/dotfile/doom/themes/cyber2.el -*- lexical-binding: t; -*-
;;; doom-cyberpunk-neon-theme.el --- Cyberpunk Neon Theme -*- no-byte-compile: t; -*-
;;; Commentary:
;;; A more modern, vibrant cyberpunk neon theme for Doom Emacs.
;;; Code:
(require 'doom-themes)

(defgroup doom-cyberpunk-neon-theme nil
  "Options for doom-cyberpunk-neon."
  :group 'doom-themes)

(defcustom doom-cyberpunk-neon-brighter-modeline t
  "If non-nil, use a brighter modeline."
  :group 'doom-cyberpunk-neon-theme
  :type 'boolean)

(defcustom doom-cyberpunk-neon-brighter-comments t
  "If non-nil, use brighter colors for comments."
  :group 'doom-cyberpunk-neon-theme
  :type 'boolean)

(defcustom doom-cyberpunk-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line."
  :group 'doom-cyberpunk-neon-theme
  :type '(choice integer boolean))

;; Color Palette
(def-doom-theme doom-cyberpunk-neon
    "A vibrant cyberpunk neon theme."

  ;; name        default     256           16
  ((bg         '("#000b1e"  nil          nil           ))
   (bg-alt     '("#12151f"  nil          nil           ))
   (base0      '("#090c10"  "black"      "black"       ))
   (base1      '("#1b2b34"  nil          nil           ))
   (base2      '("#282a36"  nil          nil           ))
   (base3      '("#3b4252"  nil          nil           ))
   (base4      '("#4c566a"  nil          nil           ))
   (base5      '("#88c0d0"  nil          nil           ))
   (base6      '("#8fbcbb"  nil          nil           ))
   (base7      '("#eceff4"  nil          nil           ))
   (base8      '("#ffffff"  "white"      "white"       ))
   (fg         '("#f8f8f2"  "white"      "white"       ))
   (fg-alt     '("#cdd6f4"  "white"      "white"       ))

   (grey       base4)
   (red        '("#ff5555"  "#ff5555"    "red"         ))
   (orange     '("#ffb86c"  "#ffb86c"    "brightred"   ))
   (green      '("#50fa7b"  "#50fa7b"    "green"       ))
   (teal       '("#0abdc6"  "#0abdc6"    "brightgreen" ))
   (yellow     '("#f1fa8c"  "#f1fa8c"    "yellow"      ))
   (blue       '("#8be9fd"  "#8be9fd"    "brightblue"  ))
   (dark-blue  '("#6272a4"  "#6272a4"    "blue"        ))
   (magenta    '("#d300c4"  "#d300c4"    "magenta"     ))
   (violet     '("#bd93f9"  "#bd93f9"    "brightmagenta"))
   (cyan       '("#8be9fd"  "#8be9fd"    "brightcyan"  ))
   (dark-cyan  '("#0abdc6"  "#0abdc6"    "cyan"        ))

   ;; UI elements
   (highlight      cyan)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-cyberpunk-neon-brighter-comments violet base5))
   (doc-comments   (doom-lighten (if doom-cyberpunk-neon-brighter-comments violet base5) 0.25))
   (constants      yellow)
   (functions      green)
   (keywords       magenta)
   (methods        cyan)
   (operators      orange)
   (type           blue)
   (strings        green)
   (variables      teal)
   (numbers        orange)
   (region         dark-blue)
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; Modeline
   (-modeline-bright doom-cyberpunk-neon-brighter-modeline)
   (-modeline-pad
    (when doom-cyberpunk-padded-modeline
      (if (integerp doom-cyberpunk-padded-modeline) doom-cyberpunk-padded-modeline 4)))

   (modeline-fg     fg)
   (modeline-bg     (if -modeline-bright base3 base1))
   (modeline-bg-l   (if -modeline-bright base4 base2))
   (modeline-bg-inactive   (doom-darken bg-alt 0.1))
   (modeline-bg-inactive-l (doom-darken bg-alt 0.15)))

  ;; --- Extra Faces ------------------------
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive))))

  )

;;; doom-cyberpunk-neon-theme.el ends here
