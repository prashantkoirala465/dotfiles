# Workflow Playbooks

## Deep Coding

1. Start session by repo name.
2. Keep Neovim in primary pane.
3. Use `prefix |` and `prefix -` for logs/tests/REPL panes.
4. Use Ctrl-hjkl via vim-tmux-navigator for seamless movement.
5. Toggle focus with `prefix z` during heavy editing.

## Debug Sprint

1. Left pane: editor.
2. Right top: test watcher.
3. Right bottom: runtime logs.
4. Use popup shell (`prefix Enter`) for one-off commands.
5. Use popup lazygit (`prefix g`) for fast commits and diffs.

## Remote Server Mode

1. Create a dedicated remote session name.
2. Keep one pane for SSH and one for monitoring.
3. Use `prefix r` after updating local config to hot-reload.
4. Rely on dual-prefix portability if remote uses default tmux habits.

## Recovery Workflow

1. Continuum autosaves every 15 minutes.
2. Resurrect captures pane content and restores sessions.
3. On restart, open tmux normally and let continuum restore.
