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

# X11 settings files
ERRFILE="$(xdg-base-dir CACHE)/X11/xsession-errors"
# Note: Some display managers will not support this (LightDM or SLiM)
XAUTHORITY="(xdg-base-dir RUNTIME)/Xauthority"

export ERRFILE
export XAUTHORITY

# GTK settings files
GTK2_RC_FILES="$(xdg-base-dir CONFIG)/gtk-2.0/gtkrc"
export GTK2_RC_FILES
