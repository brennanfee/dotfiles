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

CARGO_INSTALL_ROOT="$(xdg_base_dir DATA)/cargo"
export CARGO_INSTALL_ROOT

CARGO_HOME="$(xdg_base_dir CONFIG)/cargo"
export CARGO_HOME

path_append "${CARGO_INSTALL_ROOT}/bin"
path_append "${CARGO_HOME}/bin"

export RUSTUP_INIT_SKIP_PATH_CHECK="yes"
