#!/usr/bin/env bash

# Set PATH so it includes user's home bin folders (if they exist)
# NOTE: The order of these is important, the last one will be searched first

# Python
path_prepend "${HOME}/.local/bin"
path_prepend "${HOME}/.poetry/bin"

# Node
if command_exists yarn; then
  path_prepend "$(yarn global bin)"
fi
if command_exists npm; then
  path_prepend "$(npm config --global get prefix)/bin"
fi

# Ruby & Gems
if command_exists ruby && command_exists gem; then
  path_prepend "$(ruby -r rubygems -e 'puts Gem.user_dir')/bin"
fi

# Rust
if [[ -d "$HOME/.asdf/installs/rust/stable/bin" ]]; then
  path_prepend "${HOME}/.asdf/installs/rust/stable/bin"
fi

# Dotfiles
path_prepend "$DOTFILES/bin"
path_prepend "$DOTFILES_PRIVATE/bin"

# Home (local override), should always be the "first" to override everything else
path_prepend "${HOME}/bin"

# WSL (Windows)
[[ -d "$WIN_HOME/winfiles/bin" ]] && path_append "${WIN_HOME}/winfiles/bin"

