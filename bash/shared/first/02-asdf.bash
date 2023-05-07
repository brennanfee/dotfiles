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
ASDF_DATA_DIR="$(xdg-base-dir DATA)/asdf"
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

#### Completions and plugin scripts

if [[ -d "${ASDF_DATA_DIR}" ]]; then
  # shellcheck source=/dev/null
  source_if "${ASDF_DATA_DIR}/asdf.sh"

  # shellcheck source=/dev/null
  source_if "${ASDF_DATA_DIR}/completions/asdf.bash"
fi
