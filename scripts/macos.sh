#!/usr/bin/env bash
# macOS system defaults for a developer setup
# Run once on a fresh Mac, then reboot.

set -euo pipefail

echo "Applying macOS defaults..."

# ── Keyboard ───────────────────────────────────────
# Fastest key repeat and shortest delay
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable press-and-hold for keys (enable key repeat everywhere)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Disable auto-correct and smart features
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Enable full keyboard access for all controls (tab through dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ── Dock ───────────────────────────────────────────
# Auto-hide with effectively invisible delay
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 1000
defaults write com.apple.dock autohide-time-modifier -float 0
# Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true
# Don't show recent applications
defaults write com.apple.dock show-recents -bool false

# ── Finder ─────────────────────────────────────────
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show path bar and status bar
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# ── Animations ─────────────────────────────────────
# Speed up Mission Control animation
defaults write com.apple.dock expose-animation-duration -float 0.1
# Speed up Launchpad show/hide
defaults write com.apple.dock springboard-show-duration -float 0.1
defaults write com.apple.dock springboard-hide-duration -float 0.1

# ── Trackpad ───────────────────────────────────────
# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Increase tracking speed
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

# ── Screenshots ────────────────────────────────────
# Save screenshots to ~/Screenshots
mkdir -p "$HOME/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
# Save as PNG
defaults write com.apple.screencapture type -string "png"
# Disable shadow
defaults write com.apple.screencapture disable-shadow -bool true

# ── Power Management ──────────────────────────────
# Disable hibernation (faster sleep/wake)
sudo pmset -a hibernatemode 0
# Disable sudden motion sensor (SSD only)
sudo pmset -a sms 0

# ── Misc ───────────────────────────────────────────
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# ── Apply Changes ─────────────────────────────────
killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

echo "Done! Some changes require a reboot to take effect."
