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

#### Export environment variables for locations

# Where all the files will live
ASDF_CONFIG_HOME="$(xdg-base-dir CONFIG)/asdf"

# The main config file
ASDF_CONFIG_FILE="${ASDF_CONFIG_HOME}/asdfrc"

# The default packages files
ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-python-packages"
ASDF_NPM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-npm-packages"
ASDF_GEM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-gems"
ASDF_GOLANG_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-golang-packages"

export ASDF_CONFIG_HOME
export ASDF_CONFIG_FILE
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE
export ASDF_NPM_DEFAULT_PACKAGES_FILE
export ASDF_GEM_DEFAULT_PACKAGES_FILE
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE

# Java
source_if "${ASDF_DATA_DIR:-${HOME}/.asdf}/plugins/java/set-java-home.bash"

# DotNet
source_if "${ASDF_DATA_DIR:-${HOME}/.asdf}/plugins/dotnet/set-dotnet-env.bash"

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
          asdf install "${lang}" "${version}";
        done;
      fi
    fi
  }

  vmc() {
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
          asdf uninstall "${lang}" "${version}";
        done;
      fi
    fi
  }

  # TODO: Consider adding others
fi
