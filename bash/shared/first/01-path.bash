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

# Set PATH so it includes user's home bin folders (if they exist) and some
# infrastructural paths (flatpak, mason).

log "Path before customizations: ${PATH}"

base_data_dir=$(xdg_base_dir DATA)
base_bin_dir=$(xdg_base_dir BIN)
base_homebin_dir=$(xdg_base_dir HOMEBIN)
base_dotfiles_dir=$(xdg_base_dir DOTFILES)
base_dotfilesprivate_dir=$(xdg_base_dir DOTFILESPRIVATE)
base_cloud_dir=$(xdg_base_dir CLOUD)

### NOTE: Order is important

# Build up the path from SCRATCH, ignore any system provided path
export PATH_SYSTEM_ORIGINAL="${PATH}"
# shellcheck disable=SC2123
PATH=""

# Home (local override), should always be the "first" to override everything else
path_append "${base_homebin_dir}"

# Cloud bin should be next
path_append "${base_cloud_dir}/bin"

# Then dotfiles
path_append "${base_dotfilesprivate_dir}/bin"
path_append "${base_dotfiles_dir}/bin"

# Local bin
path_append "${base_bin_dir}"

# WSL (Windows)
path_append "${WIN_HOME:-${HOME}}/winfiles/bin"

# Neovim Mason bin path (for all the linters and other dev tools)
# I want this to be "first" among the dev language tooling so it takes precedence
path_append "${base_data_dir}/nvim/mason/bin"

# Rust installed packages
path_append "${base_data_dir}/cargo/bin"

# Flatpak
#    Global packages
path_append "/var/lib/flatpak/exports/bin"

#    User packages
path_append "${base_data_dir}/flatpak/exports/bin"

# # Nix Support
# if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix.sh ]]; then
#   builtin source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
#   export NIX_REMOTE=daemon
# fi

export PATH_BASHRC_AUGMENTED="${PATH}"
export PATH_SYSTEM_AUGMENTED="${PATH_BASHRC_AUGMENTED}:${PATH_SYSTEM_ORIGINAL}"

# Main system paths
PATH="${PATH_SYSTEM_AUGMENTED}"

unset base_data_dir
unset base_bin_dir
unset base_homebin_dir
unset base_dotfiles_dir
unset base_dotfilesprivate_dir
unset base_cloud_dir

unset system_path
export PATH

log "Path after customizations: ${PATH}"
