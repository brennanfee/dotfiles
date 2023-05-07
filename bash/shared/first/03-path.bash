#!/usr/bin/env bash

# Bash strict mode
# shellcheck disable=SC2154
([[ -n ${ZSH_EVAL_CONTEXT} && ${ZSH_EVAL_CONTEXT} =~ :file$ ]] \
  || [[ -n ${BASH_VERSION} ]] && (return 0 2> /dev/null)) && SOURCED=true || SOURCED=false
if ! ${SOURCED}; then
  set -o errexit  # same as set -e
  set -o nounset  # same as set -u
  set -o errtrace # same as set -E
  set -o pipefail
  set -o posix
  #set -o xtrace # same as set -x, turn on for debugging

  shopt -s extdebug
  IFS=$(printf '\n\t')
fi
# END Bash strict mode

# Set PATH so it includes user's home bin folders (if they exist)
# NOTE: The order of these is important, the last one will be searched first

base_data_dir=$(xdg-base-dir DATA)
base_dotfiles_dir=$(xdg-base-dir DOTFILES)
base_dotfilesprivate_dir=$(xdg-base-dir DOTFILESPRIVATE)

# Python
path_prepend "${HOME}/.local/bin"
path_prepend "${HOME}/.poetry/bin"

# Rust
if [[ -d "${CARGO_INSTALL_ROOT}/bin" ]]; then
  path_append "${CARGO_INSTALL_ROOT}/bin"
fi

# Flatpak
#    Global packages
if [[ -d "/var/lib/flatpak/exports/bin" ]]; then
  path_append "/var/lib/flatpak/exports/bin"
fi

#    User packages
if [[ -d "${base_data_dir}/flatpak/exports/bin" ]]; then
  path_append "${base_data_dir}/flatpak/exports/bin"
fi

# Dotfiles
path_prepend "${base_dotfiles_dir}/bin"
path_prepend "${base_dotfilesprivate_dir}/bin"

# Home (local override), should always be the "first" to override everything else
path_prepend "${HOME}/bin"
path_prepend "${HOME}/.bin"

# WSL (Windows)
[[ -d "${WIN_HOME:-${HOME}}/winfiles/bin" ]] && path_prepend "${WIN_HOME:-${HOME}}/winfiles/bin"

# Node
if command_exists yarn; then
  yarn_path=$(yarn global bin)
  path_append "${yarn_path}"
fi
if command_exists npm; then
  npm_path=$(npm config --global get prefix)
  path_append "${npm_path}/bin"
fi

# Ruby & Gems
if command_exists ruby && command_exists gem; then
  ruby_path=$(ruby -r rubygems -e 'puts Gem.user_dir')
  path_append "${ruby_path}/bin"
fi

unset yarn_path
unset npm_path
unset ruby_path
unset base_data_dir
unset base_dotfiles_dir
unset base_dotfilesprivate_dir
