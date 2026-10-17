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

# ydl URL...: yt-dlp with Firefox cookies (Bilibili logged-in qualities); notifies when each file is done or the run fails
ydl() {
    yt-dlp --cookies-from-browser firefox --exec 'notify-send -i video-x-generic -- "下载完成" {}' "$@" \
        || notify-send -u critical -- "下载失败" "$*"
}
