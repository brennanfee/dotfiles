#!/usr/bin/env bash

if [[ -d "$HOME/.asdf" ]]; then
    source "$HOME/.asdf/asdf.sh"

    source "$HOME/.asdf/completions/asdf.bash"
fi
