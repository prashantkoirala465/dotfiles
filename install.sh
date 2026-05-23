#!/usr/bin/env bash
# Bootstrap a fresh macOS development environment.
# Usage: curl -fsSL https://raw.githubusercontent.com/prashantkoirala465/.config/main/install.sh | bash
# Or:    git clone https://github.com/prashantkoirala465/.config ~/.config && ~/.config/install.sh

set -euo pipefail

DOTFILES="$HOME/.config"
SCRIPTS="$DOTFILES/scripts"

# ── Colors ─────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}[info]${NC} $1"; }
success() { echo -e "${GREEN}[done]${NC} $1"; }
warn()    { echo -e "${YELLOW}[warn]${NC} $1"; }
error()   { echo -e "${RED}[error]${NC} $1"; exit 1; }

# ── Preflight ──────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║     macOS Developer Environment Setup    ║"
echo "╚══════════════════════════════════════════╝"
echo ""

if [[ "$(uname)" != "Darwin" ]]; then
  error "This script is for macOS only."
fi

# ── 1. Xcode Command Line Tools ───────────────────
info "Checking Xcode CLI tools..."
if ! xcode-select -p &>/dev/null; then
  info "Installing Xcode CLI tools (this may take a while)..."
  xcode-select --install
  echo "Press enter once the installation is complete."
  read -r
else
  success "Xcode CLI tools"
fi

# ── 2. Homebrew ────────────────────────────────────
info "Checking Homebrew..."
if ! command -v brew &>/dev/null; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  success "Homebrew installed"
else
  success "Homebrew"
fi

# ── 3. Clone dotfiles (if not already here) ───────
if [[ ! -d "$DOTFILES/.git" ]]; then
  info "Cloning dotfiles..."
  git clone https://github.com/prashantkoirala465/.config.git "$DOTFILES"
  success "Dotfiles cloned"
else
  success "Dotfiles already present"
fi

# ── 4. Brew Bundle ─────────────────────────────────
info "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile" --no-lock
success "Brew packages installed"

# ── 5. Symlink home directory files ───────────────
info "Symlinking home directory files..."

symlink() {
  local src="$1" dst="$2"
  if [[ -L "$dst" ]]; then
    rm "$dst"
  elif [[ -f "$dst" ]]; then
    mv "$dst" "${dst}.backup.$(date +%s)"
    warn "Backed up existing $dst"
  fi
  ln -sf "$src" "$dst"
  success "Linked $(basename "$dst")"
}

symlink "$DOTFILES/home/.zshrc"  "$HOME/.zshrc"

# ── 6. fzf-tab plugin ─────────────────────────────
info "Cloning fzf-tab..."
FZF_TAB_DIR="$DOTFILES/home/plugins/fzf-tab"
if [[ ! -d "$FZF_TAB_DIR" ]]; then
  mkdir -p "$DOTFILES/home/plugins"
  git clone --depth 1 https://github.com/Aloxaf/fzf-tab "$FZF_TAB_DIR"
  success "fzf-tab cloned"
else
  success "fzf-tab already present"
fi

# ── 7. fzf-git.sh ─────────────────────────────────
info "Setting up fzf-git.sh..."
if [[ ! -d "$HOME/fzf-git.sh" ]]; then
  git clone https://github.com/junegunn/fzf-git.sh.git "$HOME/fzf-git.sh"
  success "fzf-git.sh cloned"
else
  success "fzf-git.sh already present"
fi

# ── 7. Tmux Plugin Manager ────────────────────────
info "Setting up TPM..."
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [[ ! -d "$TPM_DIR" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
  success "TPM installed"
else
  success "TPM already present"
fi

# Install tmux plugins
info "Installing tmux plugins..."
"$TPM_DIR/bin/install_plugins" &>/dev/null || true
success "Tmux plugins installed"

# ── 8. Go tools ───────────────────────────────────
if command -v go &>/dev/null; then
  info "Installing Go tools..."
  go install golang.org/x/tools/gopls@latest 2>/dev/null
  go install golang.org/x/tools/cmd/goimports@latest 2>/dev/null
  go install mvdan.cc/gofumpt@latest 2>/dev/null
  success "Go tools (gopls, goimports, gofumpt)"
else
  warn "Go not found, skipping Go tools"
fi

# ── 9. Neovim setup ──────────────────────────────
info "Setting up Neovim..."
NVCHAD_DIR="$HOME/.local/share/nvim/lazy/NvChad"
if [[ ! -d "$NVCHAD_DIR" ]]; then
  info "NvChad will be installed on first nvim launch"
else
  success "NvChad already present"
fi

# ── 10. Atuin (shell history) ─────────────────────
info "Setting up Atuin..."
if ! command -v atuin &>/dev/null; then
  curl -fsSL https://setup.atuin.sh | bash
  success "Atuin installed"
else
  success "Atuin already present"
fi

# ── 11. Bun ───────────────────────────────────────
info "Setting up Bun..."
if ! command -v bun &>/dev/null; then
  curl -fsSL https://bun.sh/install | bash
  success "Bun installed"
else
  success "Bun already present"
fi

# ── 12. macOS defaults ────────────────────────────
read -rp "Apply macOS system defaults? (keyboard speed, dock, finder, etc.) [y/N] " apply_macos
if [[ "$apply_macos" =~ ^[Yy]$ ]]; then
  bash "$SCRIPTS/macos.sh"
  success "macOS defaults applied"
else
  info "Skipping macOS defaults (run scripts/macos.sh later)"
fi

# ── 13. Git config ────────────────────────────────
info "Setting up Git..."
if ! git config --global user.name &>/dev/null; then
  read -rp "Git user name: " git_name
  read -rp "Git email: " git_email
  git config --global user.name "$git_name"
  git config --global user.email "$git_email"
  success "Git identity configured"
else
  success "Git identity already set ($(git config --global user.name))"
fi

# Ensure git uses the XDG config
git config --global include.path "$DOTFILES/git/config"
success "Git config linked"

# ── 14. Set default shell ─────────────────────────
info "Checking default shell..."
if [[ "$SHELL" != *"zsh"* ]]; then
  chsh -s "$(which zsh)"
  success "Default shell set to zsh"
else
  success "Default shell is zsh"
fi

# ── Done ──────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════╗"
echo "║            Setup Complete!               ║"
echo "╠══════════════════════════════════════════╣"
echo "║  1. Restart your terminal                ║"
echo "║  2. Open nvim to finish plugin install   ║"
echo "║  3. In tmux: prefix + I to load plugins  ║"
echo "║  4. Reboot if you applied macOS defaults ║"
echo "╚══════════════════════════════════════════╝"
echo ""
