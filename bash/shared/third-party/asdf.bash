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

# The location where asdf should be installed to and all the data lives
ASDF_DATA_DIR="$(xdg-base-dir DATA)/asdf"

# The default packages files
ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-python-packages"
ASDF_NPM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-npm-packages"
ASDF_GEM_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-gems"
ASDF_GOLANG_DEFAULT_PACKAGES_FILE="${ASDF_CONFIG_HOME}/default-golang-packages"

export ASDF_CONFIG_HOME
export ASDF_CONFIG_FILE
export ASDF_DATA_DIR
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE
export ASDF_NPM_DEFAULT_PACKAGES_FILE
export ASDF_GEM_DEFAULT_PACKAGES_FILE
export ASDF_GOLANG_DEFAULT_PACKAGES_FILE

#### Completions and plugin scripts

asdf_path="${ASDF_DATA_DIR:-${HOME}/.asdf}"

if [[ -d ${asdf_path} ]]; then
  # shellcheck source=/dev/null
  source "${asdf_path}/asdf.sh"

  # shellcheck source=/dev/null
  source "${asdf_path}/completions/asdf.bash"
fi

# Java
if [[ -f "${asdf_path}/plugins/java/set-java-home.bash" ]]; then
  source "${asdf_path}/plugins/java/set-java-home.bash"
fi

# DotNet
if [[ -f "${asdf_path}/plugins/dotnet/set-dotnet-env.bash" ]]; then
  source "${asdf_path}/plugins/dotnet/set-dotnet-env.bash"
fi

unset asdf_path
