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

# For other history ideas check out these articles:
#
# https://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
#
# https://askubuntu.com/questions/80371/bash-history-handling-with-multiple-terminals
#
# https://unix.stackexchange.com/questions/48713/how-can-i-remove-duplicates-in-my-bash-history-preserving-order
#

HISTCONTROL="ignoreboth:erasedups"
HISTIGNORE="[ \t]*:[fb]g:exit:ls:ls -la:sl:ll:la:lls:lla:pwd:cd:cd -:cdp:cdpp:cdd:cdi:cdt:cdtp:cdm:cdmp"
HISTIGNORE+=":cdv:cdb:cdc:cdx:cdh:cdr:cdw:* --help:* -h:history:history *:man:man *:date"
# HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
HISTFILESIZE=20000
HISTSIZE=10000
HISTFILE="$(xdg_base_dir STATE)/bash_history"

function historyclean {
  if [[ -e "${HISTFILE}" ]]; then
    local history_lock
    exec {history_lock}< "${HISTFILE}" && flock -s ${history_lock}
    history -a
    tac "${HISTFILE}" | awk '!x[$0]++' | tac > "${HISTFILE}.tmp$$"
    mv -f "${HISTFILE}.tmp$$" "${HISTFILE}"
    history -c
    history -r
    flock -u ${history_lock}
  fi
}

function historymerge {
  history -n
  history -w
  history -c
  history -r
}

trap historymerge EXIT

if [[ ";${PROMPT_COMMAND:-}" != *";historyclean"* ]]; then
  PROMPT_COMMAND="${PROMPT_COMMAND};historyclean"
fi
