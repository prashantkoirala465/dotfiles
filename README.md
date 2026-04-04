# Dotfiles

Personal macOS development environment. One command to set up a new Mac.

## Quick Start

```bash
# On a fresh Mac:
git clone https://github.com/prashantkoirala465/.config.git ~/.config
~/.config/install.sh
```

The install script handles everything: Homebrew, packages, symlinks, tmux plugins, Go tools, macOS defaults, and shell setup.

## What's Included

### Terminal & Shell

| Tool | Config | Description |
|------|--------|-------------|
| [Alacritty](https://alacritty.org/) | `alacritty/` | GPU-accelerated terminal — coolnight theme, MesloLGS Nerd Font, blur + transparency |
| [tmux](https://github.com/tmux-plugins/tpm) | `tmux/` | Modular config — C-a prefix, vim-tmux-navigator, session persistence, project workflows |
| [Atuin](https://atuin.sh/) | `atuin/` | Shell history — fuzzy search, vim keybindings, secrets filter |
| [Zsh](https://www.zsh.org/) | `home/.zshrc` | Powerlevel10k, lazy-loaded NVM/direnv, FZF with previews, zoxide, 50+ aliases |

### Editors

| Tool | Config | Description |
|------|--------|-------------|
| [Zed](https://zed.dev/) | `zed/` | Primary editor — vim mode, Go + TypeScript LSP, inlay hints, inline blame |
| [Neovim](https://neovim.io/) | `nvim/` | Terminal editor — NvChad, 8 LSP servers (TS, Go, Tailwind, ESLint), format-on-save |

### Git

| Tool | Config | Description |
|------|--------|-------------|
| [Git](https://git-scm.com/) | `git/` | Delta pager (side-by-side), pull rebase, rerere, histogram diff, aliases |
| [Lazygit](https://github.com/jesseduffield/lazygit) | `lazygit/` | Git TUI — delta integration, nerd font icons, nvim editor |

### Window Management & UI

| Tool | Config | Description |
|------|--------|-------------|
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | `aerospace/` | Tiling WM — dual-monitor routing, 80+ app rules, vim-style navigation |
| [SketchyBar](https://github.com/FelixKratz/SketchyBar) | `sketchybar/` | Custom menu bar |
| [JankyBorders](https://github.com/FelixKratz/JankyBorders) | `borders/` | Rounded window borders |

### File Management & Tools

| Tool | Config | Description |
|------|--------|-------------|
| [Yazi](https://yazi-rs.github.io/) | `yazi/` | Terminal file manager — vim navigation, catppuccin theme |
| [bat](https://github.com/sharkdp/bat) | `bat/` | Syntax-highlighted `cat` replacement |
| [btop](https://github.com/aristocratos/btop) | `btop/` | System resource monitor |

## Key Bindings

### Tmux (prefix = `C-a`)

| Key | Action |
|-----|--------|
| `\|` | Split vertical |
| `-` | Split horizontal |
| `s` | Fuzzy session picker (sessionx) |
| `g` | LazyGit popup |
| `f` | FZF directory finder |
| `t` | Run tests (auto-detects npm/go) |
| `b` | Run build |
| `d` | Run dev server |
| `Enter` | Floating shell |

### Shell Functions

| Command | Action |
|---------|--------|
| `fp` | Fuzzy project switcher → tmux session |
| `dev <dir>` | Launch dev session (Zed + terminal) |
| `y` | Yazi file manager (cd on exit) |

### Shell Aliases

| Alias | Command | Alias | Command |
|-------|---------|-------|---------|
| `gs` | `git status -sb` | `nr` | `npm run` |
| `gc` | `git commit` | `nd` | `npm run dev` |
| `gp` | `git push` | `nt` | `npm test` |
| `gl` | `git pull` | `nb` | `npm run build` |
| `lg` | `lazygit` | `gr` | `go run .` |
| `gd` | `git diff` | `gt` | `go test ./...` |
| `glg` | `git log --graph` | `gb` | `go build ./...` |

## Structure

```
~/.config/
├── install.sh              # Bootstrap script (start here)
├── Brewfile                # All Homebrew packages
├── scripts/
│   └── macos.sh            # macOS system defaults
├── home/
│   ├── .zshrc              # Shell config (symlinked to ~/)
│   └── .p10k.zsh           # Prompt theme (symlinked to ~/)
├── aerospace/              # Tiling window manager
├── alacritty/              # Terminal emulator
├── atuin/                  # Shell history
├── bat/                    # Syntax highlighting
├── borders/                # Window borders
├── btop/                   # System monitor
├── git/                    # Git workflow config
├── lazygit/                # Git TUI
├── nvim/                   # Neovim (NvChad)
├── sketchybar/             # Menu bar
├── tmux/                   # Terminal multiplexer
├── yazi/                   # File manager
└── zed/                    # Primary code editor
```

## Per-Project Environment

Drop a `.envrc` file in any project directory and `direnv` will auto-load it:

```bash
# .envrc
export DATABASE_URL=postgres://localhost/mydb
export NODE_ENV=development
```

Run `direnv allow` once per project to approve the file.

## License

MIT
