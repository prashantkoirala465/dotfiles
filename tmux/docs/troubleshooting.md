# Troubleshooting

## Plugin failed to install

- Symptom: `prefix I` does nothing.
- Cause: TPM not loaded or wrong path.
- Fix:
  1. Verify `~/.tmux/plugins/tpm` exists.
  2. Verify `run '~/.tmux/plugins/tpm/tpm'` is present in `~/.config/tmux/conf/plugins.conf`.
  3. Reload with `prefix r`.

## Navigator not switching between Neovim and tmux

- Symptom: Ctrl-hjkl stays in one context.
- Cause: Neovim plugin missing or shell process detection mismatch.
- Fix:
  1. Ensure `christoomey/vim-tmux-navigator` is installed in Neovim.
  2. Ensure tmux plugin is installed via TPM.
  3. Restart tmux server if process detection got stale.

## Colors/icons look wrong

- Symptom: odd colors or broken glyphs.
- Cause: terminal truecolor or font mismatch.
- Fix:
  1. Use a Nerd Font in terminal.
  2. Keep `default-terminal` as `tmux-256color`.
  3. Set terminal profile to support 24-bit color.

## Continuum not autosaving

- Symptom: sessions do not restore after restart.
- Cause: statusline overridden or plugin order issue.
- Fix:
  1. Keep `tmux-continuum` in plugin list.
  2. Keep `set -g @continuum-restore 'on'` enabled.
  3. Ensure statusline is enabled and not disabled by custom scripts.

## Bootstrap mismatch

- Symptom: old config still active.
- Cause: bootstrap file not sourcing modular config.
- Fix:
  1. Verify `~/.tmux.conf` has `source-file ~/.config/tmux/tmux.conf`.
  2. Run `tmux source-file ~/.tmux.conf`.
