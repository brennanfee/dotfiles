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

export PAGER="less"
export MANPAGER="less --no-lessopen --line-numbers"

export LESS="--LINE-NUMBERS --quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS --tabs=2 --use-color --QUIET --LONG-PROMPT --mouse"
LESSHISTFILE="$(xdg-base-dir CACHE)/lesshst"
export LESSHISTFILE

# if type source-highlight >/dev/null 2>&1; then
#   LESSOPEN="| $(xdg-base-dir DOTFILES)/bin/src-hilite-lesspipe.sh %s"
# elif type lesspipe >/dev/null 2>&1; then
#   LESSOPEN="| lesspipe %s"
# fi
# export LESSOPEN

function man() {
  LESS_TERMCAP_md=$'\E[1;31m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[01;44;33m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[1;32m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    command man "$@"
}
