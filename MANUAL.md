# Desktop & Dotfiles Manual

Personal manual for the Linux desktop (dwm on X11), its macOS counterpart (section 13) and the dotfiles repo.
Last reviewed: 2026-10-10.

- [1. Quick reference](#1-quick-reference)
- [2. Where things live](#2-where-things-live)
- [3. Session startup](#3-session-startup)
- [4. dwm (window manager)](#4-dwm-window-manager)
- [5. Status bar (dwmblocks)](#5-status-bar-dwmblocks)
- [6. dmenu, st, lf](#6-dmenu-st-lf)
- [7. Colour themes (`theme`)](#7-colour-themes-theme)
- [8. Fonts](#8-fonts)
- [9. Emacs (Doom)](#9-emacs-doom)
- [10. Other applications](#10-other-applications)
- [11. Scripts reference](#11-scripts-reference)
- [12. Building and installing](#12-building-and-installing)
- [13. macOS](#13-macos)
- [14. Credentials and security](#14-credentials-and-security)
- [15. Known issues](#15-known-issues)

---

## 1. Quick reference

`Super` is the dwm modifier (the Windows key).

| Do this | Keys / command |
|---|---|
| Terminal (st) | `Super+Enter` |
| Launcher (dmenu) | `Super+d` |
| Emacs | `Super+e` |
| Firefox | `Super+Shift+w` |
| File manager (lf in st) | `Super+Shift+f` |
| Screenshot | `Super+Shift+p` |
| Emoji picker | `Super+Shift+d` |
| Close window | `Super+q` |
| Toggle floating / fullscreen | `Super+f` / `Super+m` |
| Switch tag / move window to tag | `Super+1..9` / `Super+Shift+1..9` |
| Next / previous monitor | `Super+.` / `Super+,` |
| Reload colours from X resources | `Super+Shift+F5` (or `dwmc xrdb`) |
| Quit dwm (back to TTY) | `Super+Ctrl+q`, then `startx` to return |
| Switch colour theme | `theme` (list), `theme vapor`, `theme amber`, `theme overdose`, `theme moss` |
| Change wallpaper only | `changebg` (theme's), `changebg vapor`, `changebg image.png`, `changebg dir/` |
| Change English / Chinese font everywhere | `set-en-font "Family" [px]`, `set-cjk-font "Family" [px]` |
| Lock screen | `slock` (no keybinding) |

---

## 2. Where things live

### Repositories

Everything lives under `~/System/personal-infra` (`github.com:AnissL93/personal-infra`). Each part is
its own repo, added there as a git submodule:

| Path | Repo | What |
|---|---|---|
| `personal-infra/dotfiles` | `github.com:AnissL93/Dotfiles` (public) | configs, scripts, themes (this manual) |
| `personal-infra/desktop` | `github.com:AnissL93/desktop` | window-manager layer: `linux/` (x11, dunst, scripts, bin, gtk, fontconfig, cursor generator) and `mac/` (AeroSpace, skhd, borders, Mac setup); submodules `dwm` (with `dmenu/`, `dwmblocks/`), `st`, `slock`, `wallpapers` |
| `personal-infra/knowledge-forge` | `github.com:AnissL93/knowledge-forge` | public Obsidian vault template; the private vault is synced with Syncthing and improvements are folded back here |

The old locations `~/System/dotfiles` and `~/Projects/knowledge-forge` are
symlinks into `personal-infra`, so all paths in this manual still work.

To change something: commit and push inside the part (e.g. `dotfiles/`) as before, then record the
new version in `personal-infra` with `git add dotfiles && git commit`.

### New machine

```sh
git clone --recursive git@github.com:AnissL93/personal-infra.git ~/System/personal-infra
cd ~/System/personal-infra
./bootstrap.sh --dry-run      # see what it would do
./bootstrap.sh                # everything; or single steps, e.g. ./bootstrap.sh links theme
```

It works on Linux and macOS and runs that platform's steps (`./bootstrap.sh --help` lists them).
What it installs is listed in files, not in the script: `packages/apt.txt` / `packages/Brewfile`
(system packages), `packages/tools.txt` (uv, cargo, go, npm, pip tools), `packages/opt.txt` (apps
downloaded into `/opt`), `builds/*.sh` (Emacs, zathura-pdf-mupdf, mix-mpd, built from source) and
`links.txt` (config symlinks, with a platform column). To add software, add a line to one of those
files and a row to `SOFTWARE.md`. Every step can be re-run; credentials, vendor apt repos and
Firefox's first start are listed at the end as manual steps. The Firefox profile is found
automatically (`desktop/linux/bin/ff-profile`: the most recently used).

### What is linked into `$HOME`

Every config is a symlink back into `~/System/personal-infra`; the full list, per platform, is
`links.txt` (`bootstrap.sh links` creates the rows for the machine it runs on). Firefox's profile
files (`dotfiles/firefox/`: `user.js`, `chrome/userChrome.css`, `chrome/userContent.css`) are linked
by the step itself, since the profile folder name differs per machine.

**Scripts that edit these files must follow symlinks** (`sed -i --follow-symlinks`, or write through
Python `open()`), otherwise the link is replaced by a plain file and the change leaves git.

### Generated files (not in git, rewritten by `theme`)

- `~/.config/theme/current`, `emacs-theme`, `xresources`
- `~/.config/alacritty/theme.toml`
- `~/.config/dunst/dunstrc.d/theme.conf`
- Firefox `chrome/theme-colors.css`
- `~/.icons/default/index.theme`, cursor themes in `~/.local/share/icons/` (linked from `~/.icons/`)
- the "Retro Themes" VS Code extension (`local.retro-themes`)
- `~/.claude/themes/desktop.json` (Claude Code; `theme` also sets `"theme": "custom:desktop"`)
- `~/.config/theme/nvim.lua` (tokyonight palette, loaded by `nvim-config/lua/theme.lua`)
- `~/.local/share/fcitx5/themes/desktop/` (selected in `~/.config/fcitx5/conf/classicui.conf`)
- `~/.config/theme/zathurarc` (included by `zathura/zathurarc`)

### Present in dotfiles but not linked on this machine

`lf/`, `hledger/`, `thefuck/`,
and `desktop/mac/`.
Link them by hand when needed, e.g. `ln -s ~/System/dotfiles/lf ~/.config/lf`.

---

## 3. Session startup

Log in on a TTY and run `startx`. `~/.xinitrc` (`desktop/linux/x11/xinitrc`) runs, in order:

1. `source ~/.bashrc`, start a D-Bus session
2. locale (`LANG=zh_CN.UTF-8`, `LC_ALL=en_US.UTF-8`) and fcitx input-method variables
3. start `fcitx5`
4. `export WINIT_X11_SCALE_FACTOR=1` so alacritty has the same font size on both monitors (they are ~93 and ~109 DPI)
5. `xcompmgr &` (compositor)
6. `theme --wallpaper`: one wallpaper per monitor from the current theme
7. `xrdb -merge ~/.Xresources` (includes the theme colours)
8. `xset s off; xset -dpms` (no screen blanking)
9. `emacs --daemon`
10. `dwmblocks &`, then `exec dwm`

Commented out: redshift, xbacklight restore, `selmon init`, pywal. `desktop/linux/x11/start.sh` is an older,
unused variant of the same sequence.

Prompt: `~/.bashrc` sources `dotfiles/bash/prompt.sh`, which makes the oh-my-bash prompt use the 16 theme
colours (its default 256-colour codes ignore the theme and are unreadable on light themes).

Monitors: DP-2 3440×1440 and HDMI-0 2560×1440. `theme --wallpaper` picks the image by width, so the
order or connector names can change without breaking it.

---

## 4. dwm (window manager)

dwm 6.3. Config: `~/System/personal-infra/desktop/linux/dwm/config.def.h` (always edit this, not `config.h`).

### Launching

| Keys | Action |
|---|---|
| `Super+d` | dmenu_run |
| `Super+Enter` | st |
| `Super+e` | `emacsclient -c` |
| `Super+Shift+w` | `firefox-start` |
| `Super+Shift+e` | emacs-everywhere (`everywhere`) |
| `Super+Shift+p` | `screenshot` (flameshot) |
| `Super+Shift+d` | `show_emoji` |
| `Super+Shift+f` | lf in st |

### Windows

| Keys | Action |
|---|---|
| `Super+j` / `Super+k` | focus next / previous |
| `Super+v` | focus master |
| `Super+Shift+j` / `Super+Shift+k` | move window down / up the stack |
| `Super+Shift+v` | move window to master |
| `Super+q` | close |
| `Super+f` | toggle floating |
| `Super+m` | toggle real fullscreen |
| `Super+Shift+s` | sticky (visible on every tag) |
| `Super+o` / `Super+Shift+o` | one more / one fewer master window |
| `Super+h` / `Super+l` | shrink / grow master area (5%) |
| `Super+Shift+b` | toggle bar (per tag) |

### Layouts

`Super+key` picks the first layout, `Super+Shift+key` the second. `Super+Space` /
`Super+Shift+Space` cycle through all layouts (the only way to reach floating `><>`).

| Key | `Super` | `Super+Shift` |
|---|---|---|
| `t` | `[]=` tile (default) | `TTT` bottom stack |
| `y` | `[@]` spiral | `[\]` dwindle |
| `u` | `\|M\|` centred master | `~M~` centred floating master |
| `i` | `[M]` monocle | `H[]` deck |
| `[` | `HHH` grid | `###` nrowgrid |
| `]` | `---` horizontal grid | `:::` gapless grid |

### Tags and monitors

- Tags: `1 2 3 4 5 6 7 📹 🌐`. Browsers (`firefox-start`, brave, qutebrowser) open on tag 9.
- `Super+N` view, `Super+Shift+N` move window, `Super+Ctrl+N` toggle view,
  `Super+Ctrl+Shift+N` toggle window on tag; `Super+0` / `Super+Shift+0` all tags; `Super+Tab` previous tags.
- `Super+,` / `Super+.` focus monitor; `Super+Shift+,` / `Super+Shift+.` send window there.
- All monitors share one tag set: viewing a tag pulls its windows to the current monitor.

### Media keys

Brightness `xbacklight ±5`, volume `pulsemixer ±5` / mute / mic mute, play-pause `playerctl`.

### Mouse

- `Super`+left-drag move, `Super`+right-drag resize, `Super`+middle-click toggle floating.
- Click the tag bar to view a tag (right-click toggles); `Super`+click moves the window there.
- Layout symbol: left-click previous layout, right-click spiral.
- Middle-click a window title: swap with master.
- Click a status bar block: runs that block's click action (see [section 5](#5-status-bar-dwmblocks)).
  `Shift`+middle-click on the status text opens st.

### Patches you will notice

- **swallow**: a GUI program started from st replaces the terminal until it closes.
- **gaps** (5 px inside and out). Gap functions exist but have no keybindings.
- **xresources**: colours come from `dwm.*` X resources (set by `theme`).
- **dwmc**: control dwm from a shell. `dwmc xrdb` reloads colours; also `view`, `togglebar`,
  `togglefloating`, `zoom`, `killclient`, `quit`, `viewex N`, `tagex N`, `setlayoutex N`,
  `focusmon N`, `tagmon N`, `setmfact F`, and more.
- **pertag**: layout, master size and bar visibility are remembered per tag.
- **statuscmd**: clickable status blocks. **sticky**, **actualfullscreen**, **cyclelayout**,
  **keepfloatingposition** (floating windows keep their position across monitors).
- Dialog windows float and are centred automatically.

---

## 5. Status bar (dwmblocks)

Config: `dwm/dwmblocks/blocks.def.h`. Blocks, left to right (separator ` | `):

| Block | Shows | Refresh | Click |
|---|---|---|---|
| `show_weather` | weather for Markethill (wttr.in) | every 16 h, or when the cached report is from another day | left: full report in st · middle: edit script · right: re-download |
| `show_network` | upload/download speed, link type, proxy (`P` when xray runs) | 2 s | middle: edit script |
| `input_method` | keyboard icon + `中` / `EN` (fcitx5) | 1 s | left: fcitx5 settings · middle: edit script |
| `show_resource` | used/total memory | 10 s | left: htop · middle: edit script |
| `battery` | battery level | 6 s | **currently empty, see [known issues](#15-known-issues)** |
| `show_bazi` | current 八字 (year, month, day, hour pillars) | 60 s | none |
| date | `Sep 29 (Tue) 11:18PM` | 120 s | none |

- Icons are [Typicons](https://github.com/stephenhutchings/typicons.font) glyphs, printed by the
  scripts (written as `$''` etc. with the icon name in a comment). The font is in
  the assets repo (`fonts/typicons/`). Weather maps wttr.in's emoji to Typicons in `show_weather`.
- Clicks: dwm sends the button number to dwmblocks, which reruns the script with `$BUTTON` set
  (1 left, 2 middle, 3 right, 4/5 wheel), then refreshes the block.
- Refresh a block by hand: `pkill -RTMIN+N dwmblocks` (N = the block's signal: weather 1,
  input 2, memory 3, battery 4, network 5, bazi 6).
- 八字 uses the `lunar_python` library (system `python3`, installed by `packages/tools.txt`). Year and month change at the solar
  terms (立春 for the year). The hour pillar uses clock time (BST), not true solar time, which is
  about 1 h 26 min earlier in summer at this longitude.

---

## 6. dmenu, st, lf

### dmenu

`dwm/dmenu/config.def.h`. Font IBM VGA 24 px with Cubic 11 for Chinese. `Super+d` passes dwm's
theme colours. Options: `-l N` vertical list, `-i` case-insensitive, `-p` prompt, `-m` monitor.
No password, centre or fuzzy patches.

### st (default terminal)

Config: `~/System/personal-infra/desktop/linux/st/config.h` (no `config.def.h`, edit `config.h` directly).
Fonts and colours come from `~/.Xresources` (`st.*`), so a rebuild is rarely needed.
`Alt` is st's modifier:

| Keys | Action |
|---|---|
| `Alt+c` / `Alt+v` | copy / paste clipboard (`Shift+Insert` pastes too) |
| `Alt+k` / `Alt+j`, mouse wheel | scroll one line |
| `Alt+u` / `Alt+d`, `Shift+PgUp` / `Shift+PgDn` | scroll one page |
| `Alt+Shift+k` / `Alt+Shift+j` | bigger / smaller font; `Alt+Shift+Home` reset |
| `Alt+a` / `Alt+s` | more / less opaque |
| `Alt+l` / `Alt+y` | open / copy a URL on screen (dmenu) |
| `Alt+o` | copy the output of a previous command |
| `Alt+Shift+n` | new st in the same directory |

Font: IBM VGA 26.67 px (same size as alacritty) with Cubic 11 at 24 px for Chinese
(`st.fontalt0`). The Chinese font is smaller on purpose: st clips glyphs taller than the line.

### lf

Opened with `Super+Shift+f`. The config in `dotfiles/lf/lfrc` is not linked (`~/.config/lf`
missing), so lf runs with defaults. When linked: `o`/`O` mimeopen, `a` mkdir, `x` run,
`trash`, `extract`, `tar`, `zip` commands; PDFs/EPUBs open in zathura.

---

## 7. Colour themes (`theme`)

One command recolours the whole desktop.

```sh
theme          # list themes, * = current
theme vapor    # Vapor Night
theme amber    # Amber CRT
theme overdose # Overdose (light)
theme moss     # Moss (light)
```

| Theme | Look |
|---|---|
| **amber** (Amber CRT) | monochrome amber phosphor (`#ffb000` on `#140c00`); brightness and bold carry meaning; DOS-prompt wallpaper with scanlines |
| **vapor** (Vapor Night) | night purple `#1e1838`, lavender text `#ddd5f1`, frame purple `#715bad` for selection, pink `#ff6fa5` / cyan `#6fe3f0` accents; 単独で wallpaper |
| **overdose** (Overdose) | **light** theme after Needy Girl Overdose: pale pink `#fbf0fc`, indigo text `#3a2a8f`, royal-blue `#6061e7` selection like the window title bars, magenta/pink/cyan accents |
| **moss** (Moss) | **light**, muted pixel-art ruins: sage grey `#d0d2c7`, dark teal text `#2e4d45`, moss-teal `#475e4e` selection, olive/tan greens, the red cloak `#9c5754` as the warm accent |

### What it changes

| App | How | Live? |
|---|---|---|
| dwm bar, borders, dmenu | `dwm.*` X resources + `dwmc xrdb` | yes |
| st | `st.*` X resources | new windows |
| alacritty | `~/.config/alacritty/theme.toml` (imported) | yes |
| dunst | `dunstrc.d/theme.conf`, then every dunst is restarted (one can run per D-Bus session) | next notification |
| Emacs | `~/.config/theme/emacs-theme` + `load-theme` in the daemon | yes |
| VS Code | local extension "Retro Themes" (both themes) + `workbench.colorTheme` | yes |
| Firefox | `chrome/theme-colors.css` (`--t-*` variables used by `userChrome.css` / `userContent.css`) | restart Firefox |
| Obsidian (vault `/srv/sync/WorkNotes`, on macOS `~/Sync/WorkNotes`, list in `OBSIDIAN_VAULTS` in the script) | snippet `.obsidian/snippets/desktop-theme.css` (enabled automatically) overriding Obsidian's and RetroNotes' colour variables; `appearance.json` light/dark; also copies the hand-written snippets in `dotfiles/obsidian/` (e.g. `desktop-ui-size.css`, 24 px UI and text) | snippet live; light/dark on next start |
| rmpc | `~/.config/rmpc/themes/desktop.ron`: rmpc's default theme (`rmpc theme`) with the selection, tab, border, mode and progress colours from the palette; `theme: Some("desktop")` added to `config.ron` | next start of rmpc |
| cursor | pixel cursors `AmberCRT` / `VaporNight`, `~/.icons/default`, GTK setting | new windows |
| wallpaper | `feh`, one image per monitor (macOS: System Events, one image on all screens) | yes |
| macOS only | light/dark mode, SketchyBar, borders, dmenu, CodeIsland: see [section 13](#13-macos) | yes |

### Files

- `themes/theme`: the script (Python).
- `themes/<name>.conf`: the palette: `key = value` lines. Keys: `name`, `mode` (`light` or `dark`, default dark; sets Firefox `color-scheme` and the VS Code theme type), `emacs_theme`, `cursor`,
  `wallpaper_2560`, `wallpaper_3440`, and colour roles `bg bg_alt bg_hl sel dim mid fg bright
  accent accent_fg border comment string number keyword function type punct err warn ok
  color0..color15`.
- Wallpapers: in the assets repo (`github.com:AnissL93/assets`, `wallpapers/`); `.conf` files name them and
  `theme` downloads each into `~/.local/share/wallpapers` on first use (here that folder links to the clone `~/System/assets`). The 3440-wide versions never crop: vapor and moss extend their plain background colour, overdose puts the image over a blurred copy of itself. `overdose-edited.png` is the source for overdose: the fake Windows taskbar icons painted over with cloud texture, saturation 70%, `-sigmoidal-contrast 3.5,50%` (`overdose-original.png` is the untouched image).
- Emacs themes: `doom/themes/doom-amber-crt-theme.el`, `doom-vapor-night-theme.el`, `doom-overdose-theme.el`, `doom-moss-theme.el`.

### Adding a theme

1. `cp themes/vapor.conf themes/mytheme.conf` and edit colours, name and wallpapers.
2. Copy a Doom theme to `doom/themes/doom-mytheme-theme.el`, rename it, set `emacs_theme`, and
   add a `load!` line for it in `doom/config.el` next to the others. For a light theme set `mode = light`
   and pick dark text colours (the art's darker shades) so code stays readable.
3. `theme mytheme`. The cursor theme is generated automatically on first use
   (`~/System/personal-infra/desktop/linux/cursors/make-amber-cursors.py dest fill outline name`).

---

## 8. Fonts

| Role | Font | Notes |
|---|---|---|
| English monospace | PxPlus IBM VGA 8x16 | pixel font from the oldschool PC font pack; sharp only at multiples of 16 px |
| Chinese | Cubic 11 (俐方體11號) | 12 px grid: sharp at 24 / 36 px; strokes as thick as IBM VGA |
| Obsidian code blocks | PxPlus IBM VGA 8x16 | same as everywhere else |
| Status bar icons | typicons | icon font in the Unicode private-use area |
| Firefox page text | IBM VGA (UI and pages 16 px, code 16 px) | all pages forced to these fonts |

All fonts come from the assets repo (`github.com:AnissL93/assets`, `fonts/`, one folder per family with its
licence; installed as `~/.local/share/fonts/personal-infra`), StarLovePencil (`font-preset bubble`, Chinese) included.
Original links and previews of every font: `fonts/README.md` in the assets repo, and the
[website](https://anissl93.github.io/personal-infra/#fonts).

Sizes in use: dwm bar and dmenu 24 px; st 26.67 px; alacritty 20 pt (= 26.67 px);
Emacs 32 px; VS Code UI zoomed 1.5x (`window.zoomLevel` 2.2239, so its 16 px UI font shows at 24 px; editor 13.33 and terminal 17.78 = 20 / 26.67 on screen); Obsidian WorkNotes UI 24 px (snippet `desktop-ui-size.css`); dunst 18.

### Switching fonts everywhere

```sh
set-en-font                        # show current + list installed monospace fonts
set-en-font "Departure Mono" 33    # switch English font, optional pixel size
set-cjk-font                       # show current Chinese font
set-cjk-font "Cubic 11" 24         # switch Chinese font, optional pixel size
```

They edit dwm, dmenu, st, alacritty, fontconfig, Firefox, VS Code, the VS Code UI script and
Emacs, then rebuild and `sudo make install` dwm and dmenu. Restart dwm, Firefox and VS Code afterwards.

- **Chinese fallback in alacritty**: `fonts.conf` has an alias that adds the CJK font after the
  English one, only for that family, so other programs keep their normal Chinese fonts.
- **VS Code UI font** (menus, explorer, tabs): VS Code has no setting for it.
  `vscode-ui-font on` (sudo) injects CSS into `/usr/share/code/.../workbench.html`.
  Re-run after every VS Code update; ignore the "installation appears to be corrupt" warning.
  `vscode-ui-font off` removes it.

---

## 9. Emacs (Doom)

Runs as a daemon from `.xinitrc`; open a frame with `Super+e` or `emacsclient -c`.
Config: `~/.config/doom` → `dotfiles/doom/`. After changing `init.el` / `packages.el` run
`doom sync` (or the `restart emacs` script).

### Files

| File | Role |
|---|---|
| `init.el` | modules (evil, vertico, corfu, lsp via eglot, org +roam2 +noter…, mu4e, chinese +fcitx…) |
| `packages.el` | extra packages (themes, org-ref, org-roam-bibtex, org-super-agenda, slack, hledger-mode, lsp-proxy, claude-code-ide…) |
| `config.el` | main config; loads `secrets.el` first, then `org.el`, `lsp-proxy.el`, `worknotes.el` |
| `org.el` | org, agenda, capture templates |
| `lsp-proxy.el` | lsp-proxy for Python/Go/Rust/TS/JS; eglot for C/C++ and LaTeX |
| `worknotes.el` | front end for the Obsidian vault `/srv/sync/WorkNotes/` |
| `secrets.el` | private credentials, **gitignored** |
| `custom.el` | agenda file list |
| `input.el`, `meow-edit-config.el`, `research.el` | not loaded |

### Fonts and theme

IBM VGA 32 px, Chinese via `ch-font` (mapped to han/kana scripts by an `after-setting-font-hook`),
variable pitch Fuzzy Bubbles. The theme comes from `~/.config/theme/emacs-theme` (written by
`theme`), default `doom-amber-crt`.

### Keys

| Keys | Action |
|---|---|
| `C-/` | comment line |
| `C--` | kill buffer |
| `C-:` / `C-,` | toggle rime / input method |
| `C-c C-'` | Claude Code IDE menu |
| `C-c j` / `C-c e` | hledger command / capture |
| `SPC j l`, `j`, `w` | avy line / word / char jump |
| `SPC i d` / `D` / `P` / `S` | insert date / org timestamp / file path / screenshot |
| `SPC d g` | translate (en↔zh) |
| `SPC n B` / `SPC n t` | org-roam-bibtex link / transclusion mode |
| `SPC o p` | project agenda view |
| `SPC n w d/n/f/s/l/b/a/D/k/p` | WorkNotes: daily, new, find, search, link, backlinks, agenda, dashboard, kanban, pomodoro |
| `C-c S …` | Slack (`c` rooms, `u` unread, `t` thread, `r` reaction…) |
| `<f11>` (org) | org-onit doing toggle |

### Org

- Directories: `~/Notes/Org/`, roam `~/Notes/RoamNotes/`, agenda `~/Agenda/`, deft `~/Notes`.
- TODO states: TODO, PROJ, INPROCESS, NEXT, IMPORTANT, WAITING | DONE, CANCELED; and NOTE, FIXME,
  BREAK, LOVE | REVIEW.
- Agenda views: `u` super agenda, `D` daily focus, `i` in progress, `d` done, `pp` projects,
  `b` books.
- Capture: `i` inbox, `ld`/`le` life, `p`/`P` project todo, `w*` web (org-protocol), `c` citation.

### Mail

mu4e with one account (Lumai, `mbsync Lumai`). Sending goes through the Microsoft Graph API, not
SMTP. `doom/mbsyncrc` and `msmtp-gmail` are not linked; pass them with `-c`.

---

## 10. Other applications

- **Firefox**: profile `axhukcsk.default-release-1`. `user.js` forces the IBM VGA + CJK fonts on
  every page (`browser.display.use_document_fonts = 0`; icon fonts on some sites show as text),
  page size 16. `userChrome.css` themes the UI from `theme-colors.css`: square corners,
  inverted selected tab, no theme background images. Restart Firefox after `theme`.
- **VS Code**: `settings.json` sets fonts (IBM VGA, Cubic 11) and the theme; colours come from the
  "Retro Themes" extension that `theme` builds and installs.
- **alacritty**: `alacritty/linux.toml` (font, padding, block cursor), colours imported from the
  generated `theme.toml`. `alacritty/alacritty.toml` in the repo is the macOS config.
- **dunst**: `desktop/linux/dunst/dunstrc` holds layout and font; colours from `dunstrc.d/theme.conf`.
- **Cursor**: pixel-art cursors (arrow, I-beam, hand, hourglass, crosshair) generated by
  `desktop/linux/cursors/make-amber-cursors.py` at sizes 32 and 48; other shapes fall back to
  Adwaita. They must be reachable from `~/.icons` (libXcursor here does not search
  `~/.local/share/icons`).
- **Input method**: fcitx5 + Rime. The Rime data is the `rime/` submodule of personal-infra
  (小鹤双拼 + 形码辅助), linked from `~/.local/share/fcitx5/rime`.
- **Proxy**: xray via `set_proxy` (configs in `~/.config/x2ray/`, SOCKS on 127.0.0.1:10800).
- **Keyboard**: keyd is active from `/etc/keyd/default.conf` (Caps = Esc, Left Alt ↔ Left Ctrl,
  Right Alt = symbol layer).
- **redshift**: config linked (lat 54.35, lon −6.65; 6500 K day, 4000 K night), not started
  automatically.
- **Wallpaper**: `changebg` (see section 11) sets it without touching colours. pywal is no longer used.

---

## 11. Scripts reference

In `~/.config/Scripts` (`desktop/linux/scripts/`, on `PATH`) unless noted.

### Status bar

`show_weather`, `show_network`, `input_method`, `show_resource`, `battery`, `show_bazi`: see
[section 5](#5-status-bar-dwmblocks). `statusbar` and `color.sh` are leftovers.

### dmenu helpers

| Script | Does | Bound to |
|---|---|---|
| `show_emoji` | pick an emoji (from `emoji`) and copy it | `Super+Shift+d` |
| `screenshot [dir]` | flameshot: GUI, full screen or current screen; default `~/Pictures/Screenshots/` | `Super+Shift+p` |
| `getpass` | pick a `pass` entry, copy it (cleared after 45 s) | — |
| `dpass` / `get_pass` | hidden-text password prompt for `SUDO_ASKPASS` (duplicates) | — |
| `dm-mount` / `dm-mount-open` / `dm-unmount` | mount (udisks) / open / force-unmount a drive, open in lf | — |
| `snippets` | copy a saved snippet | — |
| `ccf` | look up a CCF conference/journal ranking (`ccf-list`, built by `ccf.py`) | — |
| `fetch_paper` | fetch a paper PDF + BibTeX by DOI/DBLP/title from the clipboard | — |
| `sync_nextcloud` | rsync Notes/Papers/Books with `~/DataBase/Nextcloud` | — |
| `set_proxy` | start xray with a chosen config, or stop it | — |
| `lock` | lock / suspend / poweroff / reboot menu | — |
| `bluetooth` | restart Bluetooth | — |

### System and misc

| Script | Does |
|---|---|
| `selmon [init\|current]` | arrange monitors with xrandr (mirror / side by side / current as primary) |
| `changebg [theme\|image\|dir]` | wallpaper only: no argument = current theme's (per monitor), a theme name = that theme's, an image = on every monitor, a folder = random image; colours untouched |
| `restart emacs` | kill Emacs, `doom sync`, restart the daemon (loses unsaved buffers) |
| `open <file>` | open by MIME type (sxiv, koreader, lf, xdg-open) |
| `everywhere` | emacs-everywhere popup (`Super+Shift+e`) |
| `nus-vpn` | NUS SoC VPN via openfortivpn |
| `git-clone <url>` | clone into `~/Projects` |
| `install-font <archive>` | unpack a font archive into `~/.local/share/fonts` |
| `install-stardict` | download StarDict EN↔CN dictionaries for sdcv |
| `mpv-url`, `firefox-normal`, `pocket_token.py` | macOS-only / unused / dead service |

### `~/.local/bin` (from `desktop/linux/bin/` and `dotfiles/themes/`)

`theme`, `set-en-font`, `set-cjk-font`, `vscode-ui-font`: see sections 7 and 8.

---

## 12. Building and installing

Everything installs to `/usr/local`. Edit, build, install, then restart the program.

| Program | Edit | Build and install |
|---|---|---|
| dwm | `dwm/config.def.h` | `cd dwm && rm -f config.h && make && sudo make install`, then `Super+Ctrl+q` and `startx` |
| dmenu | `dwm/dmenu/config.def.h` | `cd dwm/dmenu && rm -f config.h && make && sudo make install` |
| dwmblocks | `dwm/dwmblocks/blocks.def.h` | `cd dwm/dwmblocks && make clean && sudo make install`, then restart dwm (or `pkill dwmblocks; dwmblocks &`) |
| st | `st/config.h` | `cd st && sudo make install` |
| slock | `slock/config.def.h` | `cd slock && rm -f config.h && sudo make clean install` |

**`config.h` gotcha**: the Makefiles only copy `config.def.h` to `config.h` when `config.h` is
missing, and nothing depends on `config.def.h`. Always remove `config.h` (or `make clean`) after
editing `config.def.h`, otherwise the old settings are compiled in.

Status bar scripts are read at run time: editing them needs no rebuild.

Dependencies: libX11, libXft, libXinerama, fontconfig, xcb/xcb-res (dwm swallow), harfbuzz (st),
libcrypt/Xext/Xrandr (slock); libxft-bgra for colour emoji (`install_xft.sh`).
A new machine is set up with `~/System/personal-infra/bootstrap.sh` (see section 2).

---

## 13. macOS

The Mac runs the same setup as far as macOS allows: same fonts, themes, Emacs and keys, with a
Mac tool in place of each Linux one. Linux and macOS parts stay separate: `desktop/linux/` vs
`desktop/mac/`, the `L`/`M` rows of `links.txt` and `tools.txt`, `apt.txt` vs `Brewfile`.

### Setup

`./bootstrap.sh` runs the macOS steps: `packages tools builds fonts links emacs defaults services theme`.

- `packages/Brewfile`; apps installed by hand first need `HOMEBREW_CASK_OPTS=--adopt brew bundle --file packages/Brewfile`.
  Casks that ask for a password (Squirrel, Karabiner, Docker, Tailscale, Bitwarden) must be installed from a terminal.
- `builds`: dmenu (`desktop/mac/dmenu/dmenu.swift`, compiled with `swiftc` into `~/.local/bin`),
  `~/Applications/Zathura.app` (an AppleScript applet that hands Finder's files to zathura) and
  CodeIsland (`builds/codeisland.sh`). None needs Xcode, only the command-line tools.
- `defaults`: zathura opens PDF, EPUB and MOBI (`duti`). AZW3 is not supported (MuPDF cannot read it).
- `services`: skhd, borders, SketchyBar.
- By hand once: enable the "keymap" rules in Karabiner, allow SketchyBar/AeroSpace/skhd under Accessibility,
  and in VS Code run "Shell Command: Install 'code' in PATH" if `code` is missing.

### Linux → Mac

| Linux | Mac | Config |
|---|---|---|
| dwm | AeroSpace (+ skhd for `cmd-arrows`) | `desktop/mac/aerospace/`, `desktop/mac/skhd/` |
| dwm borders | JankyBorders | `desktop/mac/borders/` (colours from `theme`) |
| dwmblocks | SketchyBar | `desktop/mac/sketchybar/` |
| dmenu | own dmenu in Swift, same flags and keys | `desktop/mac/dmenu/`, `desktop/mac/bin/dmenu_run` |
| `getpass` | `getpass` (pass + dmenu, `pinentry-mac`) | `desktop/mac/bin/getpass`, `desktop/mac/gnupg/` |
| keyd | Karabiner-Elements, rules generated from `keyd.conf` | `keymap/mac/` |
| fcitx5 + Rime | Squirrel | `rime/` (`~/Library/Rime`) |
| st | Alacritty | `dotfiles/alacritty/alacritty.toml` |
| zathura | zathura (Homebrew) + `Zathura.app` | `dotfiles/zathura/`, `desktop/mac/zathura/` |
| dunst, slock, flameshot | Notification Center, `ctrl-cmd-q`, `cmd-shift-5` | |
| redshift | f.lux | |
| playerctl, pulsemixer | nowplaying-cli, switchaudio-osx | |
| — | CodeIsland: Claude Code / Codex status around the notch | `builds/codeisland.sh` |

### Keys

AeroSpace uses the dwm keys with `cmd` as the dwm `Super` (full list: `desktop/mac/aerospace/README.md`):
`cmd-d` dmenu, `cmd-enter` Alacritty, `cmd-e` Emacs, `cmd-shift-e` emacs-everywhere, `cmd-shift-w` Firefox,
`cmd-shift-d` emoji, `cmd-j/k` focus next/previous, `cmd-shift-j/k` swap, `cmd-h/l` resize,
`cmd-1..0` workspaces (summoned onto the focused monitor, like dwm tags), `cmd-shift-1..0` send window,
`cmd-shift-comma/period` window to monitor, `cmd-shift-space` layout, `cmd-shift-b` hide the bar,
`cmd-q` close window, `cmd-shift-f5` reload. Core macOS app shortcuts (`cmd-c/v/x/z/s/t/w/f`, `cmd-space`
Spotlight, `cmd-tab`) are unchanged; `alt-tab` toggles the last two workspaces.

### Status bar (SketchyBar)

32 px, PxPlus font, theme bar colours (`~/.config/theme/sketchybar.sh`).

- Left: workspaces 1–10, always shown, as dwm tags: a number icon followed by one icon per app on it (dwm's
  `tagicons[]`); the focused one uses the selection colours. Then the focused app.
- Left of the notch: weather (wttr.in; click for the full report).
- Right, in dwmblocks order: network rate, input method (`中` / `EN`), memory (click: btop), battery, date.
- Plugins in `desktop/mac/sketchybar/plugins/`; edits apply after `sketchybar --reload` (`cmd-shift-f5`).

### Themes and fonts

`theme NAME` also sets on the Mac: macOS light/dark mode, SketchyBar, the window borders, dmenu (reads the
bar colours on every run), CodeIsland (restarted to take the bar colours) and the wallpaper (one image on
every screen, through System Events). Everything shared (Alacritty, Emacs, VS Code, Firefox, Obsidian
vault `~/Sync/WorkNotes`, rmpc, Claude Code, Neovim) works as on Linux.

The fonts are the same; on Retina sizes are in points (1 pt = 2 px), so PxPlus is 16 everywhere
(the native 8x16 grid): Alacritty 16, Emacs 16 (Linux 27), VS Code 16 with no zoom
(`dotfiles/vscode/settings-mac.json`), Obsidian 16 (`body.mod-macos` in `desktop-ui-size.css`),
SketchyBar and dmenu 16. CodeIsland uses Cubic 11 at 11/22 (its grid).

### Emacs

emacs-plus@31 (`Brewfile`), same Doom config. Mac-only parts are behind `(featurep :system 'macos)`:
notes in `~/DataBase/Notes/` (variable `my/notes`), the `macos` module, copilot, eat and claude-code.

### CodeIsland

`builds/codeisland.sh` checks out the latest release of github.com/wxtsky/CodeIsland in
`~/System/CodeIsland`, patches it (`builds/codeisland-pixel.py`: Cubic 11 pixel font, the theme bar colours
for its panel and text, no self-update) and installs it to `/Applications`. Re-run it to update. If a new
release breaks the patch, the script says so; the counts it prints show how many calls were patched.

---

## 14. Credentials and security

- **Never commit secrets.** Emacs credentials (Slack tokens and cookies, Bilibili cookie) are in
  `doom/secrets.el`, gitignored and loaded at the top of `config.el`. `doom/graph-token` and
  `tokens/` are gitignored.
- **The repo is public** (`github.com/AnissL93/Dotfiles`). Its history was squashed on 2026-09-30
  because older commits contained credentials (Bilibili cookie, Graph, Hugging Face and Asana
  tokens, a Gmail password, proxy configs); revoke those if not done yet.
- Other secret locations (paths only): `~/.password-store` (getpass), `~/.config/x2ray/*.json`
  (set_proxy), `~/.authinfo`.
- Before committing: check the staged diff for tokens, cookies, `Pass`, JWTs (`eyJ…`).

---

## 15. Known issues

Found while writing this manual; not yet fixed.

| Where | Problem |
|---|---|
| `desktop/linux/x11/xinitrc`, `desktop/linux/x11/start.sh` | `exec fcitx5 &gt; /dev/null &amp;` contains HTML entities; should be `fcitx5 > /dev/null &` |
| `desktop/linux/scripts/battery` | `main` call is commented out, so the battery block is always empty |
| `desktop/linux/scripts/selmon` | `[ $1 > 1 ]` is a redirect, not a comparison: the single-monitor branch never runs and a file named `1` is created |
| `desktop/linux/scripts/sync_nextcloud` | "Download / All" actually uploads |
| `desktop/linux/scripts/lock` | `sudo -A suspend` (not a program) and `SUDO_ASKPASS` is not set anywhere |
| `desktop/linux/scripts/bluetooth` | uses `sudo` without `-A` (fails from dmenu) and a SysV init path |
| `desktop/linux/scripts/open` | EPUB case never matches; calls an `unproxy` alias that scripts cannot see |
| `desktop/linux/scripts/fetch_paper` | `eval` on clipboard text (shell injection) |
| `desktop/linux/scripts/git-clone`, `install-font` | typo `${repo_nam}`; archive paths with directories break |
| `desktop/linux/scripts/show_network` | first run has no previous counters; counts loopback traffic too |
| `~/.bashrc:189` | `"$HOME:System/JetBrains/..."` adds `$HOME` and a relative path to `PATH` |
| Emacs `config.el` | `SPC o p` defined twice; `org-todo-keywords` set twice (see `doom/CONFIG-REVIEW.md`) |
| dwm | gap-adjust functions and slock have no keybindings |
| Firefox | forced page fonts turn some icon fonts into text |
