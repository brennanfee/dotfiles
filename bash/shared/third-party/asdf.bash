#!/usr/bin/env bash

if [[ -d "$HOME/.asdf" ]]; then
  # shellcheck source=/dev/null
  source "$HOME/.asdf/asdf.sh"

  # shellcheck source=/dev/null
  source "$HOME/.asdf/completions/asdf.bash"
fi
