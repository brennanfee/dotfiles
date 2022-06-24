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

# XDG variablers, if not already set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"
export XDG_BIN_HOME="${XDG_BIN_HOME:-${HOME}/.local/bin}"

function xdg-base-dir() {
  case $1 in

    CONFIG | CONFIGHOME)
      echo "${XDG_CONFIG_HOME:-${HOME}/.config}"
      ;;

    CONFIGDIRS)
      echo "${XDG_CONFIG_DIRS:-"/etc/xdg"}"
      ;;

    BIN | BINHOME)
      echo "${XDG_BIN_HOME:-${HOME}/.local/bin}"
      ;;

    DATA | DATAHOME)
      echo "${XDG_DATA_HOME:-${HOME}/.local/share}"
      ;;

    DATADIRS)
      echo "${XGD_DATA_DIRS:-"/usr/local/share/:/usr/share/"}"
      ;;

    CACHE | CACHEHOME)
      echo "${XDG_CACHE_HOME:-${HOME}/.cache}"
      ;;

    STATE | STATEHOME)
      echo "${XDG_STATE_HOME:-${HOME}/.local/state}"
      ;;

    RUNTIME | RUNTIMEDIR)
      echo "${XDG_RUNTIME_DIR:-/run/user/${UID}}"
      ;;

    EXECS | EXECUTABLES | EXES)
      echo "${HOME}/.local/bin"
      ;;

    HOME)
      echo "${HOME}"
      ;;

    "")
      echo "${HOME}"
      ;;

    *)
      xdg-user-dir "$1"
      ;;

  esac
}
