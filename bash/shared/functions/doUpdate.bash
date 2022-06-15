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

function doUpdate() {
  if [[ "${OS_SECONDARY}" == "ubuntu" || "${OS_SECONDARY}" == "debian" ]]; then
    sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt-get autoremove -y
  else
    echo "Unable to determine os or distribution."
  fi

  if command_exists flatpak; then
    flatpak upgrade -y
  fi
}

alias doup=doUpdate
