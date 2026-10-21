#!/bin/sh
# macOS preferences.
# Apply on a Mac with:  source macos/defaults.sh
# Each setting guards itself, so sourcing on a non-macOS machine is a no-op.

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Use the iTerm2 preferences stored in this repo.
if [ -d "/Applications/iTerm.app" ]; then
  defaults write com.googlecode.iterm2 PrefsCustomFolder "$DOTFILES/iterm2"
fi
