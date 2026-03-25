# Dotfiles

Personal macOS configuration files managed with Git. These live in `~/.config/` and cover terminal, editor, window management, and system tools.

## What's Included

### Terminal & Shell

| Tool | Config | Description |
|------|--------|-------------|
| [Alacritty](https://alacritty.org/) | `alacritty/` | GPU-accelerated terminal with custom coolnight theme, MesloLGS Nerd Font, blur + transparency |
| [tmux](https://github.com/tmux-plugins/tpm) | `tmux/` | Modular config with dual prefix (Ctrl-a / Ctrl-b), adaptive statusline, TPM plugins |
| [Fish](https://fishshell.com/) | `fish/` | Fish shell config |
| [Atuin](https://atuin.sh/) | `atuin/` | Shell history sync and search |
| [thefuck](https://github.com/nvbn/thefuck) | `thefuck/` | Auto-correct mistyped commands |

### Editors

| Tool | Config | Description |
|------|--------|-------------|
| [Neovim](https://neovim.io/) | `nvim/` | LazyVim-based config with LSP, treesitter, and custom keymaps |
| [Zed](https://zed.dev/) | `zed/` | Settings, keymap, and themes |

### Window Management & UI

| Tool | Config | Description |
|------|--------|-------------|
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | `aerospace/` | Tiling WM with dual-monitor workspace routing, starts sketchybar on launch |
| [SketchyBar](https://github.com/FelixKratz/SketchyBar) | `sketchybar/` | Custom macOS menu bar with workspace indicators and system info |
| [JankyBorders](https://github.com/FelixKratz/JankyBorders) | `borders/` | Rounded window borders, teal active / invisible inactive |

### File Management & Monitoring

| Tool | Config | Description |
|------|--------|-------------|
| [Yazi](https://yazi-rs.github.io/) | `yazi/` | Terminal file manager with catppuccin-mocha flavor |
| [bat](https://github.com/sharkdp/bat) | `bat/` | `cat` replacement with syntax highlighting and custom themes |
| [btop](https://github.com/aristocratos/btop) | `btop/` | System resource monitor |
| [htop](https://htop.dev/) | `htop/` | Process viewer |

### Other

| Tool | Config | Description |
|------|--------|-------------|
| [Raycast](https://raycast.com/) | `raycast/` | Launcher extensions (GitHub, Color Picker, IP Geolocation, etc.) |
| [Spicetify](https://spicetify.app/) | `spicetify/` | Spotify client customization |
| [Pomodoro TUI](https://github.com/zhamlin/pomodoro-tui) | `pomodoro-tui/` | Terminal pomodoro timer |
| [OpenCode](https://github.com/opencode-ai/opencode) | `opencode/` | AI coding tool config |

### AI Agent Skills

| Directory | Description |
|-----------|-------------|
| `agents/` | Shared agent skills (Vercel React/composition patterns) |
| `crush/` | Crush agent skills and superpowers |
| `goose/` | Goose agent skills and superpowers |

> Note: `crush/` and `goose/` share the same skills subtree and are supersets of `agents/`.

## Setup

```bash
# Clone
git clone https://github.com/prashantkoirala465/dotfiles.git ~/.config

# Or clone elsewhere and symlink what you need
git clone https://github.com/prashantkoirala465/dotfiles.git ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/alacritty ~/.config/alacritty
# ... etc
```

### Dependencies

```bash
# Core
brew install --cask alacritty
brew install neovim tmux fish atuin thefuck

# Window management
brew install --cask aerospace
brew install borders sketchybar
brew install --cask sf-symbols

# File & system tools
brew install yazi bat btop htop

# Fonts
brew install --cask font-meslo-lg-nerd-font
```

### tmux Plugin Setup

```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Inside tmux, press prefix + I to install plugins
```

## Structure

```
~/.config/
├── aerospace/          # AeroSpace tiling WM
├── alacritty/          # Alacritty terminal + themes
├── agents/             # AI agent skills
├── atuin/              # Shell history
├── bat/                # bat themes
├── borders/            # Window borders
├── btop/               # System monitor
├── crush/              # Crush agent skills
├── fish/               # Fish shell
├── goose/              # Goose agent skills
├── htop/               # Process viewer
├── nvim/               # Neovim (LazyVim)
├── opencode/           # OpenCode AI
├── pomodoro-tui/       # Pomodoro timer
├── raycast/            # Raycast extensions
├── sketchybar/         # macOS menu bar
├── spicetify/          # Spotify customization
├── thefuck/            # Command correction
├── tmux/               # tmux config (modular)
├── yazi/               # File manager
└── zed/                # Zed editor
```

## License

MIT
