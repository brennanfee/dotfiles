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

## TODO: Setup for neovim instead of vim

export VIM_VER
VIM_VER="$($(command -v vim) --version | grep "Vi IMproved" | awk '{print $5}' | sed -e 's/\.//g' || true)"
export EDITOR='vim'
export GIT_EDITOR='vim'
export SVN_EDITOR='vim'
export LESSEDIT='vim'

export VISUAL='vim'
# if command_exists code; then
#   export VISUAL='code'
# elif command_exists atom; then
#   export VISUAL='atom'
# elif command_exists gvim; then
#   export VISUAL='gvim'
# else
#   export VISUAL='vim'
# fi
