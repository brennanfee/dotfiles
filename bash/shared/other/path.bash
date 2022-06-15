#!/usr/bin/env bash

# Bash strict mode
# shellcheck disable=SC2154
([[ -n ${ZSH_EVAL_CONTEXT} && ${ZSH_EVAL_CONTEXT} =~ :file$ ]] ||
 [[ -n ${BASH_VERSION} ]] && (return 0 2>/dev/null)) && SOURCED=true || SOURCED=false
if ! ${SOURCED}; then
  set -o errexit # same as set -e
  set -o nounset # same as set -u
  set -o errtrace # same as set -E
  set -o pipefail
  set -o posix
  #set -o xtrace # same as set -x, turn on for debugging

  shopt -s extdebug
  IFS=$(printf '\n\t')
fi
# END Bash scrict mode

# Set PATH so it includes user's home bin folders (if they exist)
# NOTE: The order of these is important, the last one will be searched first

# Python
path_prepend "${HOME}/.local/bin"
path_prepend "${HOME}/.poetry/bin"

# Node
if command_exists yarn; then
  path_prepend "$(yarn global bin || true)"
fi
if command_exists npm; then
  path_prepend "$(npm config --global get prefix || true)/bin"
fi

# Ruby & Gems
if command_exists ruby && command_exists gem; then
  path_prepend "$(ruby -r rubygems -e 'puts Gem.user_dir' || true)/bin"
fi

# Rust
asdf_path="${ASDF_DATA_DIR:-${HOME}/.asdf}"
if [[ -d "${asdf_path}/installs/rust/stable/bin" ]]; then
  path_prepend "${asdf_path}/installs/rust/stable/bin"
fi

# Flatpak
if [[ -d "/var/lib/flatpak/exports/bin" ]]; then
  path_append "/var/lib/flatpak/exorts/bin"
fi

flatpak_bin="$(xdg-base-dir DATA)/flatpak/exports/bin"
if [[ -d ${flatpak_bin} ]]; then
  path_append "${flatpak_bin}"
fi

# Dotfiles
path_prepend "$(xdg-base-dir DOTFILES || true)/bin"
path_prepend "$(xdg-base-dir DOTFILESPRIVATE || true)/bin"

# Home (local override), should always be the "first" to override everything else
path_prepend "${HOME}/bin"
path_prepend "${HOME}/.bin"

# WSL (Windows)
[[ -d "${WIN_HOME:-${HOME}}/winfiles/bin" ]] && path_append "${WIN_HOME:-${HOME}}/winfiles/bin"

unset asdf_path
unset flatpak_bin
