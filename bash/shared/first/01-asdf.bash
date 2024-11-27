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

# The location where asdf should be installed to and all the data lives
ASDF_DATA_DIR="$(xdg_base_dir DATA)/asdf"
if [[ ! -d "${ASDF_DATA_DIR}" ]]; then
  ASDF_DATA_DIR="${XDG_DATA_HOME}/asdf"
  if [[ ! -d "${ASDF_DATA_DIR}" ]]; then
    ASDF_DATA_DIR="${HOME}/.local/share/asdf"
    if [[ ! -d "${ASDF_DATA_DIR}" ]]; then
      ASDF_DATA_DIR="${HOME}/.asdf"
    fi
  fi
fi

export ASDF_DATA_DIR

# Where all the files will live
ASDF_CONFIG_HOME="$(xdg_base_dir CONFIG)/asdf"
export ASDF_CONFIG_HOME

# The main config file
export ASDF_CONFIG_FILE="${ASDF_CONFIG_HOME}/asdfrc"

# Plugin specific settings

## Python
# ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-python-packages"

## Dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1

## Node
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-node-packages"
export ASDF_NODEJS_AUTO_ENABLE_COREPACK=""
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY="latest_available"

## Ruby
export ASDF_GEM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-ruby-packages"

## Golang
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-golang-packages"
export ASDF_GOLANG_MOD_VERSION_ENABLED="true"

## Rust
export ASDF_CRATE_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-rust-packages"

#### Completions and plugin scripts

if [[ -d "${ASDF_DATA_DIR}" ]]; then
  # shellcheck source=/dev/null
  source_if "${ASDF_DATA_DIR}/asdf.sh"

  # shellcheck source=/dev/null
  source_if "${ASDF_DATA_DIR}/completions/asdf.bash"

  # Java
  source_if "${ASDF_DATA_DIR}/plugins/java/set-java-home.bash"

  # DotNet
  source_if "${ASDF_DATA_DIR}/plugins/dotnet/set-dotnet-env.bash"

  # Go
  source_if "${ASDF_DATA_DIR}/plugins/golang/set-env.bash"
fi

# fzf integration
if command_exists fzf; then
  vmi() {
    local lang=${1}

    if [[ -z ${lang} ]]; then
      lang=$(asdf plugin-list | fzf)
    fi

    if [[ -n ${lang} ]]; then
      local versions
      versions=$(asdf list-all "${lang}" | fzf --tac --no-sort --multi)
      if [[ -n ${versions} ]]; then
        # shellcheck disable=2116
        for version in $(echo "${versions}"); do
          asdf install "${lang}" "${version}"
        done
      fi
    fi
  }

  vmu() {
    local lang=${1}

    if [[ -z ${lang} ]]; then
      lang=$(asdf plugin-list | fzf)
    fi

    if [[ -n ${lang} ]]; then
      local versions
      versions=$(asdf list "${lang}" | fzf -m)
      if [[ -n ${versions} ]]; then
        # shellcheck disable=2116
        for version in $(echo "${versions}"); do
          asdf uninstall "${lang}" "${version}"
        done
      fi
    fi
  }

  # TODO: Consider adding others
fi
