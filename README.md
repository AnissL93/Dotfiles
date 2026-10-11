# Dotfiles

App configs and colour themes for my Linux (dwm on X11) and macOS (AeroSpace) desktops.

This repo is one part of [personal-infra](https://github.com/AnissL93/personal-infra), where it is a
submodule. `bootstrap.sh` there installs the apps and links these files into `$HOME` (the list is
`links.txt`). Website with the theme gallery and every app: <https://anissl93.github.io/personal-infra/>.

**User manual: [MANUAL.md](MANUAL.md)** (keys, themes, fonts, scripts, macOS, known issues).

## What's here

| Path | What |
|---|---|
| `themes/` | 200 palettes (`NAME.conf`) and the `theme` command that applies one to every app; helpers to design palettes (`design`, `oklch`), make pixel-art wallpapers (`pixelate`) and themes from a picture (`theme-from-picture`) |
| `doom/` | Doom Emacs config |
| `nvim-config/` | Neovim (Lua, lazy.nvim; fork of [magidc/nvim-config](https://github.com/magidc/nvim-config)) |
| `alacritty/` | shared `alacritty.toml` + `linux.toml` / `macos.toml` |
| `kitty/` | the macOS terminal, with st's keys |
| `bash/` | prompt and desktop environment for bash (Linux) |
| `vscode/` | `settings.json`, plus `settings-mac.json` |
| `firefox/` | `user.js`, `userChrome.css`, `userContent.css` |
| `obsidian/` | UI-size snippet for the themed vault |
| `zathura/` | document viewer |
| `claude/` | Claude Code skills |
| `lf/`, `hledger/`, `thefuck/` | lf, a sample hledger journal, thefuck settings (not linked by default) |

## Themes

```sh
theme            # list
theme vapor      # apply everywhere: dwm, st, alacritty, kitty, emacs, nvim, vscode, firefox, …
```

Generated colour files are written outside the repo (`~/.config/theme/` and per-app files), so
switching themes leaves git clean. Browse them all in the
[gallery](https://anissl93.github.io/personal-infra/gallery.html).

## Editing

Files in `$HOME` are symlinks into this repo: edit in place, commit and push here, then bump the
submodule in personal-infra (`git add dotfiles && git commit`). Scripts that edit these files must
follow symlinks (`sed -i --follow-symlinks`), or the link is replaced by a plain file.
