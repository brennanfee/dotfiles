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

function setup_ghostty() {
  log "Checking if we are running in Ghostty."

  if [[ -z "${GHOSTTY_RESOURCES_DIR}" ]]; then
    log "Shell not running in Ghostty, exiting."
    return 0
  fi

  log "Shell is running in Ghostty, hooking in shell integration (if needed)."

  if [[ -z ${bash_preexec_imported:-} ]]; then
    log "Ghostty shell integration not already linked in, adding."
    source_if "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
  else
    log "Ghostty shell integration already linked in."
  fi
}

setup_ghostty
