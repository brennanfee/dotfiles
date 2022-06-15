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

export PAGER="less"
export MANPAGER="less"

export LESS="--LINE-NUMBERS --quit-if-one-screen --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --chop-long-lines --tabs=4 --window=-4 --quiet"
export LESSHISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/lesshst"

if type source-highlight >/dev/null 2>&1; then
  export LESSOPEN="| ~/.dotfiles/bin/src-hilite-lesspipe.sh %s"
elif type lesspipe >/dev/null 2>&1; then
  export LESSOPEN="| lesspipe %s"
fi

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
