---
name: theme-from-picture
description: Use when the user shares a picture or wallpaper and asks for a new desktop colour theme based on it, or asks for a pixel / retro / 8-bit version of a picture as a wallpaper, in the ~/System dotfiles `theme` system (dwm, st, alacritty, dunst, firefox, obsidian, vscode, emacs).
---

# Theme from picture

A theme is one `~/System/dotfiles/themes/NAME.conf` palette + two wallpapers + a doom emacs theme.
`themes/theme NAME` applies it everywhere; read its docstring once if unsure.

## Steps

1. **Look at the picture** (Read it) and sample its colours:
   `themes/pixelate SRC --sample`
2. **Wallpapers** → `themes/wallpapers/NAME-2560.png` (2560x1440) and `NAME-3440.png` (3440x1440).
   - Pixel / retro look requested: `themes/pixelate SRC OUT W H --palette '#..,#..'` (16 hand-picked
     colours from step 1: darks, mids, the subject's highlights, one or two small accents like
     stamens). Run once without `--palette` to see what the photo gives. `--px` = block size
     (8–12), `--spread` = dither strength, `--center x,y` = crop focus; for 3440 from a narrower photo x also picks where the padding goes
     (subject touching the right edge → `--center 1,0.5` pads only the left).
     Busy or film-grained illustrations turn to mush at the defaults: use `--px 8 --spread 16`.
   - Already pixel art on flat bg: crop the art, then `themes/pixelate ART OUT W H --art BG --scale 2.5`
     (hard-edged upscale, centred on BG). Integer-ish scale keeps pixels crisp.
   - Otherwise (the picture as is): `themes/pixelate SRC OUT W H --photo` (same crop/padding, no pixels).
   - Ultrawide padding: `--fill blur` (default) suits pixel art; for a textured photo/print use
     `--fill mirror` and pick `--center x` so no subject lies within the padding width of an edge.
     Repeating patterns: `--fill crop` (crop to the ratio, no padding) — mirroring makes
     kaleidoscope twins.
     Also `--fill crop` when one edge is empty (street, sky, floor): `--center x,0` cuts only
     the bottom, `x,1` only the top — usually better than any padding for paintings.
   - **Recolour** asked ("make it purple"): add `--duotone DARK,LIGHT [--mix 70]` to the `pixelate`
     call (`--mix` = % of the duotone; works with `--photo` and the pixel look). Record the recipe in the .conf comment (see `lilac.conf`).
   - **Both original and pixel** asked: theme `NAME` (original wallpapers) + `NAME-pixel.conf`
     holding only `base = NAME`, `name`, and the two `NAME-pixel-*.png` wallpaper paths.
   - **Read both results** and check them; fix and redo before moving on.
   - Keep the source as `NAME-original.<ext>`.
3. **Palette** → copy an existing `.conf` (e.g. `miku.conf`) to `NAME.conf`; change the comment line,
   `name`, `emacs_theme = doom-NAME`, `cursor`, wallpaper paths, every colour.
   **Design it, don't sample it**: sampled hex values look mechanical and too saturated. Read the
   picture's mood and 2–3 signature hues (`themes/oklch --from '#hex'` gives L C H), then put ONE
   line in the .conf and let `themes/design NAME` compute every colour (it also rebuilds the emacs
   theme and prints contrasts):
   `# design: dark base=248 accent=200 border=235 syntax=12,245,190,295,70`
   - `base`: hue tinting the neutrals (bg…fg); `accent` / `border`: the signature hues (muted);
     `syntax`: keyword, function, string, type, number hues — analogous to the picture plus one
     complement, not every colour it has. Options: `accent_l=.52` for light text on a dark theme's
     accent, `accent_c`, `base_c`. `./design` with no args explains the rest.
   - Only hand-set colours `design` doesn't cover (e.g. `bar`/`bar_fg`, see `miku.conf`).
   - Light picture/theme: add `mode = light` (see `moss.conf`).
   - **Light and dark** asked: `NAME.conf` (one mode) + `NAME-dark.conf` with `base = NAME` and its
     own `name`, `mode`, `emacs_theme`, `cursor` and every colour (see `garden-dark.conf`);
     run `doom-theme` for both.
4. **Emacs**: done by `design`; for a hand-made palette run `themes/doom-theme NAME --force`.
5. **Check** (from `themes/`): no missing keys, and contrast of `fg` on `bg`, `accent_fg` on `accent`
   ≥ 4.5 (the latter is text in the dwm bar, status bars, Obsidian chrome):
   ```bash
   python3 -B -c "
   from importlib.machinery import SourceFileLoader as L
   m = L('t', 'theme').load_module(); t = m.load('NAME'); print(set(m.load('blossom')) - set(t) - {'base'} or 'keys ok')
   def lum(h):
       c = [int(h[i:i+2], 16) / 255 for i in (1, 3, 5)]
       c = [x / 12.92 if x <= .03928 else ((x + .055) / 1.055) ** 2.4 for x in c]
       return .2126 * c[0] + .7152 * c[1] + .0722 * c[2]
   for a, b in [('fg', 'bg'), ('accent_fg', 'accent')] + [(k, 'bg') for k in ('string', 'number', 'keyword', 'function', 'type', 'err', 'ok')]:
       x, y = sorted([lum(t[a]), lum(t[b])]); print(a, 'on', b, round((y + .05) / (x + .05), 1))"
   ```
6. Tell the user: `theme NAME` applies it. Don't apply or commit unless asked. Wallpapers are
   gitignored: they need `git add -f`.

## Common mistakes

- Every key another `.conf` has must exist: the per-app writers index them directly.
- Ultrawide (3440): `pixelate` extends the sides with a blurred edge; a subject cut by the
  photo's edge smears into that padding — move the padding to the clean side with `--center`.
- Light picture → light theme: syntax colours must be dark enough on `bg` (≥ 4.5; comments ~3).
- Don't hand-edit generated files under `~/.config`; change the `.conf` or the `theme` script.
