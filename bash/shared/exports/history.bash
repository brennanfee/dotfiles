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

export HISTCONTROL=${HISTCONTROL:-}${HISTCONTROL+,}ignoredups
export HISTCONTROL=${HISTCONTROL:-}${HISTCONTROL+,}ignorespace
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ls -la:sl:ll:la:lls:lla:pwd:cd:cdp:cdpp:cdd:cdi:cdt:cdtp:cdm:cdmp:cdv:cdb:cdc:cdx:cdh:cdr:cdw:* --help *'
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
export HISTFILESIZE=5000
export HISTSIZE=5000
HISTFILE="$(xdg_base_dir STATE)/bash_history"
export HISTFILE
