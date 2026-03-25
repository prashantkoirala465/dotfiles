# Visual Style

## Glass-Classic

This profile is tuned for a premium minimal look:

- single-row statusline
- low-noise separators
- soft active window pill
- subtle icon usage (mostly text)

## Palette

- Base background: `colour235`
- Elevated surface: `colour237`
- Primary text: `colour252`
- Muted text: `colour244`
- Accent: `colour81`
- Warning: `colour179`
- Alert: `colour210`

## Segment Design

- Left: command-mode badge (when prefix pressed), session, shortened path
- Center: window list with soft active highlight
- Right: online, battery, date/time

## Tuning

- Change accent: edit `pane-active-border-style`, `window-status-current-style`, and final time segment in `~/.config/tmux/conf/ui.conf`.
- Keep statusline readable by preserving muted separators (`colour244`).
- If battery or online plugins are unavailable, those segments disappear automatically.

## Reload

Run inside tmux:

`prefix r`

Or:

`tmux source-file ~/.tmux.conf`
