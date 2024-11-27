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

if command_exists bat; then
  export BAT_BIN="bat"
  alias cat="bat"
  alias bat="bat --terminal-width=-5"
  alias batcat="bat"
elif command_exists batcat; then
  export BAT_BIN="batcat"
  alias cat="batcat"
  alias bat="batcat"
  alias batcat="batcat --terminal-width=-5"
else
  export BAT_BIN="cat"
  alias bat="cat"
  alias batcat="cat"
fi

if [[ "${BAT_BIN}" == "bat" || "${BAT_BIN}" == "batcat" ]]; then
  export MANROFFOPT="-c"

  if [[ -x "${DOTFILES}/bin/batpipe" ]]; then
    eval "$("${DOTFILES}/bin/batpipe")"
    export BATPIPE_TERM_WIDTH=-5
    export MANPAGER="less -R --use-color -Dd+r -Du+b"
  else
    export MANPAGER="sh -c 'col -bx | batcat -l man'"
  fi

  if command_exists rg; then
    function batrg() {
      rg -S -p "$@" | less -R
    }
    function batgrep() {
      rg -S -p "$@" | less -R
    }
  else
    function batgrep() {
      grep "$@" | less
    }
  fi
else
  export LESS="--LINE-NUMBERS --quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS --tabs=2 --use-color --QUIET --LONG-PROMPT --mouse"
  export MANPAGER="less --no-lessopen --line-numbers"
fi

LESSHISTFILE="$(xdg_base_dir CACHE)/lesshst"
export LESSHISTFILE
