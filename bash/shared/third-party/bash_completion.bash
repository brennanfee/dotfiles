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

# Bash Completion
completions_loaded=0
if [[ -f "/usr/local/etc/bash_completion" ]]; then
  # shellcheck disable=SC1091
  source "/usr/local/etc/bash_completion"
  completions_loaded=1
fi

if [[ ${completions_loaded} == 0 && -f "/etc/bash_completion" ]]; then
  source "/etc/bash_completion"
  completions_loaded=1
fi

if [[ ${completions_loaded} == 0 && -f "/usr/share/bash-completion/bash_completion" ]]; then
  source "/usr/share/bash-completion/bash_completion"
  completions_loaded=1
fi

unset completions_loaded
