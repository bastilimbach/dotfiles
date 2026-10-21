#!/bin/sh
# macOS preferences.
# Apply on a Mac with:  source macos/defaults.sh
# Each setting guards itself, so sourcing on a non-macOS machine is a no-op.

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Use the iTerm2 preferences stored in this repo.
if [ -d "/Applications/iTerm.app" ]; then
  defaults write com.googlecode.iterm2 PrefsCustomFolder "$DOTFILES/iterm2"
fi

# macOS Settings
if [ "$(uname -s)" = "Darwin" ]; then

  # --- Keyboard ---------------------------------------------------------
  # Fast key repeat and a short initial delay.
  defaults write -g KeyRepeat -int 2
  defaults write -g InitialKeyRepeat -int 15
  # Repeat keys when held instead of showing the accent picker.
  defaults write -g ApplePressAndHoldEnabled -bool false

  # --- Trackpad ---------------------------------------------------------
  # Tap to click.
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write -g com.apple.mouse.tapBehavior -int 1
  # Tracking speed.
  defaults write -g com.apple.trackpad.scaling -float 1.5

  # --- Finder -----------------------------------------------------------
  # Default to column view ("Nlsv" list, "icnv" icon, "clmv" column, "Flwv" gallery).
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
  # Search the current folder by default (rather than the whole Mac).
  defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

  # --- Dock -------------------------------------------------------------
  defaults write com.apple.dock tilesize -int 51
  defaults write com.apple.dock largesize -int 128
  # Don't show recently-used apps in the Dock.
  defaults write com.apple.dock show-recents -bool false
  # Minimize windows into their application's icon.
  defaults write com.apple.dock minimize-to-application -bool true

  # --- Opt-in tweaks (currently OFF on this machine) --------------------
  # Show all filename extensions.
  defaults write com.apple.finder AppleShowAllExtensions -bool true
  # Show hidden files.
  defaults write com.apple.finder AppleShowAllFiles -bool true
  # Show the path bar and status bar in Finder windows.
  defaults write com.apple.finder ShowPathbar -bool true
  defaults write com.apple.finder ShowStatusBar -bool true
  # Show the full POSIX path in the Finder window title.
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
  # Don't warn when changing a file extension.
  defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

  # Apply the changes by restarting the affected apps.
  for app in Dock Finder SystemUIServer; do
    killall "$app" >/dev/null 2>&1
  done

fi
