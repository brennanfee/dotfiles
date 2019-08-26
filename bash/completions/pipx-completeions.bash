#!/usr/bin/env bash

if [[ -f "$HOME/.local/bin/pipx" ]]; then
  eval "$(register-python-argcomplete pipx)"
fi
