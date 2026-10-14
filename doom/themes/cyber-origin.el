;;; doom-cyberpunk-neon-theme.el --- custom theme for Doom Emacs -*- no-byte-compile: t; -*-
;;; Commentary:
;;; Code:
;;
(require 'doom-themes)


;; ; Variables
(defgroup doom-cyberpunk-neon-theme nil
  "Options for doom-custom."
  :group 'doom-themes)

(defcustom doom-cyberpunk-neon-brighter-modeline nil
  "If non-nil, use a brighter modeline."
  :group 'doom-cyberpunk-neon-theme
  :type 'boolean)

(defcustom doom-cyberpunk-neon-brighter-comments nil
  "If non-nil, use brighter colors for comments."
  :group 'doom-cyberpunk-neon-theme
  :type 'boolean)

(defcustom doom-cyberpunk-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line.
Can be an integer to determine the exact padding."
  :group 'doom-cyberpunk-neon-theme
  :type '(choice integer boolean))


;;
(def-doom-theme doom-cyberpunk-neon
    "A custom theme based on the user's color scheme."

  ;; name        default   256       16
  ((bg         '("#000b1e" nil       nil            ))
   (bg-alt     '("#0a1120" nil       nil            ))
   (base0      '("#0c0f1e" "black"   "black"        ))
   (base1      '("#1a1f35" nil       nil            ))
   (base2      '("#282c44" nil       nil            ))
   (base3      '("#3c405c" nil       nil            ))
   (base4      '("#4c5480" nil       nil            ))
   (base5      '("#5a65a5" nil       nil            ))
   (base6      '("#6a78c8" nil       nil            ))
   (base7      '("#7a8bf0" nil       nil            ))
   (base8      '("#8a9fff" "white"   "white"        ))
   (fg         '("#b8c4ff" "white"   "white"        ))
   (fg-alt     '("#8a9fff" "white"   "white"        ))

   (grey       base4)
   (red        '("#ff3377" "#ff3377" "red"          ))
   (orange     '("#ff7700" "#ff7700" "brightred"    ))
   (green      '("#00ff99" "#00ff99" "green"        ))
   (teal       '("#00e6e6" "#00e6e6" "brightgreen"  ))
   (yellow     '("#ffcc00" "#ffcc00" "yellow"       ))
   (blue       '("#3399ff" "#3399ff" "brightblue"   ))
   (dark-blue  '("#004488" "#004488" "blue"         ))
   (magenta    '("#cc33ff" "#cc33ff" "magenta"      ))
   (violet     '("#9933ff" "#9933ff" "brightmagenta"))
   (cyan       '("#00ffff" "#00ffff" "brightcyan"   ))
   (dark-cyan  '("#0088aa" "#0088aa" "cyan"         ))

   (highlight      magenta)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      base2)
   (builtin        cyan)
   (comments       (if doom-cyberpunk-neon-brighter-comments violet base4))
   (doc-comments   (doom-lighten (if doom-cyberpunk-neon-brighter-comments violet base4) 0.3))
   (constants      red)
   (functions      green)
   (keywords       magenta)
   (methods        cyan)
   (operators      violet)
   (type           yellow)
   (strings        orange)
   (variables      teal)
   (numbers        orange)
   (region         base2)
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (-modeline-bright doom-cyberpunk-neon-brighter-modeline)
   (-modeline-pad
    (when doom-cyberpunk-padded-modeline
      (if (integerp doom-cyperpunk-padded-modeline) doom-cyberpunk-neon-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-bg     (if -modeline-bright base3 base1))
   (modeline-bg-l   (if -modeline-bright base4 base2))
   (modeline-bg-inactive   (doom-darken bg-alt 0.1))
   (modeline-bg-inactive-l (doom-darken bg-alt 0.15)))

  ;; --- extra faces ------------------------
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))

   ;; --- major-mode faces -------------------
   ))

;;; doom-cyberpunk-neon-theme.el ends here
