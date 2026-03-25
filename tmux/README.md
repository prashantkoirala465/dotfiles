# Tmux 10x Setup

Neovim-centric tmux setup with dual-prefix portability, adaptive statusline, and lean plugins.

## Layout

- `~/.tmux.conf` -> bootstrap loader
- `~/.config/tmux/tmux.conf` -> module loader
- `~/.config/tmux/conf/core.conf` -> runtime defaults
- `~/.config/tmux/conf/keybinds.conf` -> keymaps
- `~/.config/tmux/conf/workflows.conf` -> popups/copy mode/workflow helpers
- `~/.config/tmux/conf/ui.conf` -> adaptive hybrid statusline
- `~/.config/tmux/conf/plugins.conf` -> TPM + plugin list

## Dual Prefix

- Primary: `Ctrl-a`
- Secondary: `Ctrl-b`

Both work by design for cross-machine portability.

## Install

1. Ensure tmux 3.x+ and git are installed.
2. Ensure TPM exists at `~/.tmux/plugins/tpm`:
   - `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
3. Reload tmux config:
   - `tmux source-file ~/.tmux.conf`
4. Install plugins:
   - inside tmux: `prefix + I`

## Daily

- Reload config: `prefix r`
- Split horizontal: `prefix |`
- Split vertical: `prefix -`
- Zoom pane: `prefix z`
- Popup shell: `prefix Enter`
- Popup lazygit: `prefix g`

See detailed docs in `~/.config/tmux/docs`.

## Visual style

- Glass-Classic profile docs: `~/.config/tmux/docs/visual-style.md`
