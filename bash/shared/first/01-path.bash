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

function set_path() {
  log "Path before customizations: ${PATH}"

  local base_data_dir base_bin_dir base_homebin_dir base_dotfiles_dir base_dotfilesprivate_dir
  local base_cloud_dir base_state_dir base_config_dir uv_tool_dir
  local has_uv has_coreutils has_findutils has_diffutils
  local path_system_original path_core_additions

  base_data_dir=$(xdg_base_dir DATA)
  base_bin_dir=$(xdg_base_dir BIN)
  base_homebin_dir=$(xdg_base_dir HOMEBIN)
  base_dotfiles_dir=$(xdg_base_dir DOTFILES)
  base_dotfilesprivate_dir=$(xdg_base_dir DOTFILESPRIVATE)
  base_cloud_dir=$(xdg_base_dir CLOUD)
  base_state_dir=$(xdg_base_dir STATE)
  base_config_dir=$(xdg_base_dir CONFIG)
  has_uv=0
  has_coreutils=0
  has_findutils=0
  has_diffutils=0
  uv_tool_dir=""

  path_system_original="${PATH}"
  # shellcheck disable=SC2123
  PATH=""

  ### NOTE: Order is important

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

  # Isn't this being set by MISE automatically (for the installed rust?)
  # # Rust installed packages
  # path_append "${base_data_dir}/cargo/bin"

  # Flatpak
  #    Global packages
  path_append "/var/lib/flatpak/exports/bin"

  #    User packages
  path_append "${base_data_dir}/flatpak/exports/bin"

  path_core_additions="${PATH}"
  PATH="${path_core_additions}:${path_system_original}"

  # We need to activate Mise first in order to inspect what applications are installed (many of which
  # might be installed by Mise itself).
  if command_exists mise; then
    export RUSTUP_INIT_SKIP_PATH_CHECK="yes"
    export MISE_RUSTUP_HOME="${base_state_dir}/rustup"
    export MISE_CARGO_HOME="${base_data_dir}/cargo"

    export MISE_NODE_DEFAULT_PACKAGES_FILE="${base_config_dir}/mise/default-node-packages"
    export MISE_NODE_COREPACK="true"

    log "Path befire FIRST mise activate: ${PATH}"
    log "Mise found, calling CUSTOM activate FIRST TIME."
    source_or_error "${base_dotfiles_dir}/bash/assets/custom_mise_activate.bash"
    log "Path after FIRST mise activate: ${PATH}"

    if command_exists uv; then
      has_uv=1
      uv_tool_dir="$(uv tool dir)"
    fi

    if command_exists coreutils; then
      has_coreutils=1
    fi

    if command_exists findutils; then
      has_findutils=1
    fi

    if command_exists diffutils; then
      has_diffutils=1
    fi

    # Now deactivate to revert changes to the path
    mise deactivate -y --silent
    log "Path after mise deactivate: ${PATH}"
  else
    log "Mise not found, skipping Mise activate."
  fi

  PATH="${path_core_additions}"

  if [[ has_uv -eq 1 ]]; then
    export UV_TOOL_BIN_DIR="${HOME}/.local/uv/bin"
    path_append "${UV_TOOL_BIN_DIR}"
    path_append "${uv_tool_dir}"
  fi

  if [[ has_coreutils -eq 1 ]]; then
    path_prepend "${base_dotfiles_dir}/bin/coreutils"
  fi

  if [[ has_findutils -eq 1 ]]; then
    path_prepend "${base_dotfiles_dir}/bin/findutils"
  fi

  if [[ has_diffutils -eq 1 ]]; then
    path_prepend "${base_dotfiles_dir}/bin/diffutils"
  fi

  PATH="${PATH}:${path_system_original}"

  log "Path after customizations: ${PATH}"

  # Now activate MISE "for real", this is the one that will stick around
  if command_exists mise; then
    log "Mise found, calling CUSTOM activate."
    source_or_error "${base_dotfiles_dir}/bash/assets/custom_mise_activate.bash"

    # Some mise aliases
    alias ms="mise"
    alias msx="mise x --"
    alias misex="mise x --"
    alias msr="mise r --"
    alias miser="mise r --"

    # Mise Completion
    eval "$(mise completion bash)"
  fi

  log "Final after customizations and Mise activation: ${PATH}"
}

set_path
