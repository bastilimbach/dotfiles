#!/bin/sh

system_type=$(uname -s)

if [ "$system_type" = "Darwin" ]; then

  if [ -d "/Applications/iTerm.app" ]; then
    echo "Setting iTerm preference folder"
    defaults write com.googlecode.iterm2 PrefsCustomFolder "$DOTFILES/.iterm2"
  fi

fi
