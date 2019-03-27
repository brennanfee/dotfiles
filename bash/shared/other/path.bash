#!/usr/bin/env bash

# Set PATH so it includes user's home bin folders (if they exist)
# NOTE: The order of these is important, the last one will be searched first

# Dotfiles
path_prepend "$DOTFILES/bin"
path_prepend "$DOTFILES_PRIVATE/bin"

# Home (local override), should always be the "first" to override everything else
path_prepend "${HOME}/bin"

# WSL (Windows)
[[ -d "$WIN_HOME/winfiles/bin" ]] && path_append "${WIN_HOME}/winfiles/bin"

# Python
path_append "${HOME}/.local/bin"
if command_exists poetry; then
  path_append "${HOME}/.poetry/bin"
fi

# Node
if command_exists yarn; then
  path_append "$(yarn global bin)"
fi
if command_exists npm; then
  path_append "$(npm config --global get prefix)/bin"
fi

# Ruby & Gems
if command_exists ruby && command_exists gem; then
  path_append "$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
fi
