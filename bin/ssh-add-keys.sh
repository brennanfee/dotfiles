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

# Finds all private key files (that are protected, based on mode bits)
# and adds each to ssh agent
for filename in "${HOME}"/.ssh/*; do
  perms=$(stat "${filename}" | sed -n '/^Access: (/{s/Access: (\([0-9]\+\).*$/\1/;p}')

  filetype=$(file "${filename}")

  if [[ "${perms}" == "0600" && "${filetype}" == *"private key" ]]; then
    ssh-add "${filename}"
  fi
done
