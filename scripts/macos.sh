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
# Allow quitting Finder via Cmd+Q (closes all open windows)
defaults write com.apple.finder QuitMenuItem -bool true
# Disable warning before emptying trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# Show ~/Library folder (hidden by default)
chflags nohidden "$HOME/Library" 2>/dev/null || true
# Show /Volumes folder
sudo chflags nohidden /Volumes 2>/dev/null || true

# ── Anti-Pollution (no .DS_Store everywhere) ─────────
# Don't create .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Don't create .DS_Store on USB drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

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

# ── UI Polish ──────────────────────────────────────
# Disable annoying "shake to find cursor"
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool true
# Speed up window resize animations
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# Disable smooth scrolling (snappier feel)
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
# Always show scroll bars when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
# Subpixel font smoothing on external monitors (sharper text)
defaults write NSGlobalDomain AppleFontSmoothing -int 1
# Disable focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false
# Disable automatic window tabbing
defaults write NSGlobalDomain AppleWindowTabbingMode -string "manual"

# ── Menu Bar ───────────────────────────────────────
# Show seconds in clock
defaults write com.apple.menuextra.clock ShowSeconds -bool true
# Show date in menu bar clock
defaults write com.apple.menuextra.clock ShowDate -int 1
# Show battery percentage
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

# ── App Behavior ───────────────────────────────────
# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false
# Save documents to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# Disable resume system-wide (no restored windows on app launch)
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# ── Misc ───────────────────────────────────────────
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# ── Apply Changes ─────────────────────────────────
for app in "Dock" "Finder" "SystemUIServer" "cfprefsd"; do
  killall "$app" 2>/dev/null || true
done

echo "Done! Some changes require a logout/reboot to take effect."
