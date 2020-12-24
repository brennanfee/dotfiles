#!/usr/bin/env bash

if [[ -d "$HOME/.asdf" ]]; then
  # shellcheck source=/dev/null
  source "$HOME/.asdf/asdf.sh"

  # shellcheck source=/dev/null
  source "$HOME/.asdf/completions/asdf.bash"
fi

# Java
if [[ -f "$HOME/.asdf/plugins/java/set-java-home.bash" ]]; then
  source "$HOME/.asdf/plugins/java/set-java-home.bash"
fi

# DotNet
if [[ -f "$HOME/.asdf/plugins/dotnet/set-dotnet-home.bash" ]]; then
  source "$HOME/.asdf/plugins/dotnet/set-dotnet-home.bash"
fi

