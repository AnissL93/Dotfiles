# Shell settings for the dwm desktop; sourced at the end of ~/.bashrc (after oh-my-bash).
# ~/.bashrc itself is not in git (it holds private keys).

# desktop scripts and ~/.local/bin (theme, set-*-font, ...)
case ":$PATH:" in *":$HOME/.config/Scripts:"*) ;; *) PATH="$HOME/.config/Scripts:$PATH" ;; esac
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$HOME/.local/bin:$PATH" ;; esac
export PATH

# default terminal for scripts that use $TERMINAL
export TERMINAL=st

# symlinks bold + underlined so they stand out on monochrome themes
export LS_COLORS="${LS_COLORS}:ln=01;04;36"

# prompt colours follow the desktop theme
source "$(dirname "${BASH_SOURCE[0]}")/prompt.sh"

# lazygit: own config + colours written by `theme`
export LG_CONFIG_FILE="$HOME/.config/lazygit/config.yml,$HOME/.config/theme/lazygit.yml"
