# 🏠 My Dotfiles

<div align="center">

![macOS](https://img.shields.io/badge/macOS-000000?style=for-the-badge&logo=apple&logoColor=white)
![Zsh](https://img.shields.io/badge/Zsh-F15A24?style=for-the-badge&logo=zsh&logoColor=white)
![GNU Stow](https://img.shields.io/badge/GNU%20Stow-4EAA25?style=for-the-badge&logo=gnu&logoColor=white)
![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Alacritty](https://img.shields.io/badge/Alacritty-F46D01?style=for-the-badge&logo=alacritty&logoColor=white)

_A carefully curated collection of configuration files for a productive macOS development environment_

[Installation](#-installation) •
[Features](#-features) •
[Applications](#-applications) •
[Customization](#-customization) •
[Troubleshooting](#-troubleshooting)

</div>

## 📖 Overview

Welcome to my personal dotfiles repository! This collection represents years of refinement and optimization for a macOS development environment. These configurations are designed to provide a seamless, productive, and aesthetically pleasing computing experience.

### 🎯 Philosophy

- **Minimalism**: Clean, focused configurations without unnecessary bloat
- **Productivity**: Optimized workflows and keyboard-driven interfaces
- **Consistency**: Unified color schemes and interaction patterns
- **Modularity**: Easy to maintain and customize individual components

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/prashantkoirala465/dotfiles.git ~/dotfiles

# Navigate to the directory
cd ~/dotfiles

# Install with GNU Stow (install stow first if needed: brew install stow)
stow .
```

## 📋 Prerequisites

Before installing these dotfiles, ensure you have the following installed:

### Essential Tools

- **Homebrew**: Package manager for macOS
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- **GNU Stow**: Symlink farm manager
  ```bash
  brew install stow
  ```
- **Git**: Version control (usually pre-installed)
  ```bash
  xcode-select --install
  ```

### Recommended Applications

Install these applications for the full experience:

```bash
# Terminal & Shell
brew install --cask alacritty
brew install zsh zsh-completions

# Development Tools
brew install --cask neovide
brew install neovim

# System Utilities
brew install --cask aerospace
brew install borders
brew install btop htop
brew install yazi

# Optional: Sketchybar (macOS menu bar)
brew install --cask sf-symbols
brew install sketchybar
```

## 🔧 Installation

### Method 1: Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/prashantkoirala465/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Backup existing configurations (optional but recommended)
mkdir -p ~/.config-backup
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.config-backup/
[ -d ~/.config ] && cp -r ~/.config ~/.config-backup/

# Use GNU Stow to create symlinks
stow .

# Restart your terminal or source the new configuration
source ~/.zshrc
```

### Method 2: Manual Installation

If you prefer to cherry-pick specific configurations:

```bash
# Clone the repository
git clone https://github.com/prashantkoirala465/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Create symlinks manually for specific applications
stow --target=$HOME .config/nvim
stow --target=$HOME .config/alacritty
stow --target=$HOME .zshrc
# ... add other configurations as needed
```

### Method 3: Selective Installation

```bash
cd ~/dotfiles

# Install only specific configurations
stow --target=$HOME/.config .config/nvim     # Neovim only
stow --target=$HOME/.config .config/alacritty # Alacritty only
```

## ✨ Features

### 🎨 Unified Theme

- **Dark theme** optimized for extended coding sessions
- **Consistent color palette** across all applications
- **Custom coolnight theme** for Alacritty terminal

### ⚡ Performance Optimizations

- **Lazy loading** for shell plugins and functions
- **Optimized startup times** for all configured applications
- **Resource-efficient** configurations

### 🔒 Security & Privacy

- **Secure defaults** for all applications
- **Privacy-focused** settings where applicable
- **Safe credential handling**

## 📱 Applications

<details>
<summary><strong>🖥️ Terminal & Shell</strong></summary>

### Alacritty

- **Fast GPU-accelerated terminal**
- Custom themes including the exclusive `coolnight` theme
- Optimized font rendering and performance settings
- Keybinding configurations for productivity

**Configuration highlights:**

- Font: Optimized for code readability
- Opacity and background settings
- Comprehensive keybinding setup
- Multiple theme options

### Zsh

- **Highly customized shell experience**
- Aliases for common development tasks
- Performance optimizations
- Git integration and prompt customization

**Key features:**

- Fast directory navigation
- Enhanced command completion
- Git status in prompt
- Productivity aliases
</details>

<details>
<summary><strong>📝 Development Environment</strong></summary>

### Neovim

- **Modern, extensible text editor**
- LSP (Language Server Protocol) support
- Plugin management with lazy loading
- Custom keybindings and workflow optimizations

**Features:**

- Syntax highlighting for 100+ languages
- Auto-completion and IntelliSense
- Git integration
- File explorer and fuzzy finder
- Debugging support

### Neovide

- **GPU-accelerated Neovim GUI**
- Enhanced visual experience
- Smooth scrolling and animations
- Font ligature support

</details>

<details>
<summary><strong>🎮 Window Management & System</strong></summary>

### AeroSpace

- **Tiling window manager for macOS**
- Keyboard-driven window management
- Multiple workspace support
- Custom layouts and rules

### Borders

- **Window border enhancement**
- Visual feedback for active windows
- Customizable border styles and colors

### Sketchybar

- **Custom macOS menu bar**
- System information display
- Customizable widgets and indicators
- Integration with system events
</details>

<details>
<summary><strong>🔧 System Utilities</strong></summary>

### btop/htop

- **Advanced system monitors**
- Real-time resource usage
- Process management
- Custom themes and layouts

### Yazi

- **Terminal file manager**
- Fast file navigation
- Preview support for various file types
- Vim-like keybindings

</details>

## 🗂️ Repository Structure

```
~/dotfiles/
├── .config/                      # XDG configuration directory
│   ├── aerospace/                # AeroSpace window manager
│   │   └── aerospace.toml
│   ├── alacritty/                # Alacritty terminal
│   │   ├── alacritty.toml
│   │   └── themes/               # Custom themes (git submodule)
│   ├── borders/                  # Window borders
│   │   └── bordersrc
│   ├── btop/                     # System monitor
│   │   └── btop.conf
│   ├── htop/                     # System monitor
│   │   └── htoprc
│   ├── neovide/                  # Neovim GUI
│   │   └── config.toml
│   ├── nvim/                     # Neovim configuration
│   │   ├── init.lua
│   │   ├── lazy-lock.json
│   │   ├── lazyvim.json
│   │   ├── stylua.toml
│   │   └── lua/                  # Lua configuration modules
│   ├── sketchybar/               # Menu bar customization
│   │   ├── sketchybarrc
│   │   └── colors.sh
│   └── yazi/                     # File manager
│       ├── yazi.toml
│       ├── keymap.toml
│       ├── theme.toml
│       └── package.toml
├── .zshrc                        # Zsh shell configuration
└── README.md                     # This file
```

## 🎨 Customization

### Modifying Configurations

1. **Edit configurations directly:**

   ```bash
   cd ~/dotfiles
   # Edit any configuration file
   vim .config/alacritty/alacritty.toml
   ```

2. **Apply changes:**

   ```bash
   # If using stow, changes are automatically symlinked
   # For some applications, you might need to restart them
   ```

3. **Commit your changes:**
   ```bash
   git add .
   git commit -m "Update configuration"
   git push
   ```

### Adding New Applications

1. **Create configuration directory:**

   ```bash
   mkdir -p .config/new-app
   ```

2. **Add your configuration files:**

   ```bash
   cp ~/.config/new-app/config.conf .config/new-app/
   ```

3. **Update this README** to document the new application

### Theme Customization

The repository includes a custom `coolnight` theme for Alacritty. To modify themes:

1. **Edit existing themes:**

   ```bash
   vim .config/alacritty/themes/themes/coolnight.toml
   ```

2. **Add new themes:**
   ```bash
   cp .config/alacritty/themes/themes/coolnight.toml .config/alacritty/themes/themes/mynewtheme.toml
   ```

## 🛠️ Troubleshooting

### Common Issues

<details>
<summary><strong>Stow conflicts with existing files</strong></summary>

**Problem:** GNU Stow reports conflicts when trying to create symlinks.

**Solution:**

```bash
# Remove or backup existing configurations
mv ~/.config/conflicting-app ~/.config/conflicting-app.bak
stow --restow .
```

</details>

<details>
<summary><strong>Terminal doesn't reflect new changes</strong></summary>

**Problem:** Changes to shell configuration don't appear.

**Solution:**

```bash
# Reload shell configuration
source ~/.zshrc
# Or restart terminal application
```

</details>

<details>
<summary><strong>Application doesn't recognize new configuration</strong></summary>

**Problem:** Application still uses old settings.

**Solution:**

1. Restart the application
2. Check if application has a reload command
3. Verify symlinks are created correctly:
   ```bash
   ls -la ~/.config/app-name
   ```
   </details>

<details>
<summary><strong>Fonts not displaying correctly</strong></summary>

**Problem:** Terminal or applications show missing glyphs.

**Solution:**

```bash
# Install a Nerd Font
brew install --cask font-jetbrains-mono-nerd-font
# Update terminal font settings
```

</details>

### Debugging Steps

1. **Check symlinks:**

   ```bash
   stow --dry-run .  # See what would be done
   ls -la ~/.config  # Verify symlinks exist
   ```

2. **Validate configurations:**

   ```bash
   # Most apps have config validation
   nvim --headless +checkhealth +qa  # Neovim
   alacritty --print-events           # Alacritty
   ```

3. **Check logs:**
   ```bash
   # Application-specific log locations
   tail -f ~/.config/app/logs/app.log
   ```

## 🔄 Maintenance

### Updating Configurations

```bash
cd ~/dotfiles
git pull origin main
stow --restow .
```

### Backing Up Current State

```bash
# Create a backup before major changes
cp -r ~/.config ~/.config-backup-$(date +%Y%m%d)
```

### Cleaning Up

```bash
# Remove broken symlinks
find ~ -type l ! -exec test -e {} \; -delete 2>/dev/null
```

## 🤝 Contributing

While these are personal dotfiles, suggestions and improvements are welcome!

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-improvement`
3. **Commit changes**: `git commit -m 'Add amazing improvement'`
4. **Push to branch**: `git push origin feature/amazing-improvement`
5. **Create Pull Request**

### Guidelines

- Test configurations on a clean macOS installation when possible
- Document any new dependencies or installation steps
- Follow existing code style and organization
- Update this README for any significant changes

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- **GNU Stow** - For elegant dotfile management
- **Homebrew** - For macOS package management
- **The open source community** - For the amazing tools and inspiration

---

<div align="center">

**Made with ❤️ for productivity and aesthetics**

_If you found these dotfiles helpful, consider giving the repository a ⭐!_

</div>

## 📞 Support

If you encounter issues or have questions:

1. **Check the [Issues](https://github.com/prashantkoirala465/dotfiles/issues)** for existing solutions
2. **Create a new issue** with detailed information about your problem
3. **Include system information**: macOS version, shell version, etc.

---

_Last updated: October 2025_
