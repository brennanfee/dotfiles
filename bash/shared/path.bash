#!/usr/bin/env bash

# Set PATH so it includes user's home bin folders (if they exist)
# NOTE: The order of these is important, the last one will be searched first
path_prepend "$DOTFILES/bin"
path_prepend "$DOTFILES_PRIVATE/bin"
path_prepend "${HOME}/bin"

if command -v yarn 2>/dev/null; then
    path_append "$(yarn global bin)"
fi
