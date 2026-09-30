;;; ../../System/dotfile/doom/themes/cyber1.el -*- lexical-binding: t; -*-
;;; doom-cyberpunk-neon-theme.el --- Modern Cyberpunk Neon Theme -*- no-byte-compile: t; -*-
;;; Commentary:
;;; A vibrant, modernized cyberpunk theme for Doom Emacs.
;;; Code:
(require 'doom-themes)

(defgroup doom-cyberpunk-neon-theme nil
  "Options for doom-cyberpunk-neon."
  :group 'doom-themes)

(defcustom doom-cyberpunk-neon-brighter-modeline t
  "Use a brighter modeline."
  :group 'doom-cyberpunk-neon-theme
  :type 'boolean)

(defcustom doom-cyberpunk-neon-brighter-comments t
  "Use brighter colors for comments."
  :group 'doom-cyberpunk-neon-theme
  :type 'boolean)

(defcustom doom-cyberpunk-neon-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds padding to the mode-line."
  :group 'doom-cyberpunk-neon-theme
  :type '(choice integer boolean))

(def-doom-theme doom-cyberpunk-neon
    "A vibrant, futuristic cyberpunk theme."

  ((bg         '("#090c1b" nil       nil            ))
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

   (-modeline-bright doom-cyberpunk-neon-brighter-modeline)
   (-modeline-pad
    (when doom-cyberpunk-neon-padded-modeline
      (if (integerp doom-cyberpunk-neon-padded-modeline) doom-cyberpunk-neon-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-bg     (if -modeline-bright base6 base3))
   (modeline-bg-l   (if -modeline-bright base7 base4))
   (modeline-bg-inactive   (doom-darken bg-alt 0.2))
   (modeline-bg-inactive-l (doom-darken bg-alt 0.25)))

  ((line-number &override) :foreground base5)
  ((line-number-current-line &override) :foreground fg :weight 'bold)
  (mode-line
   :background modeline-bg :foreground modeline-fg
   :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
  (mode-line-inactive
   :background modeline-bg-inactive :foreground modeline-fg
   :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive))))

;;; doom-cyberpunk-neon-theme.el ends here
