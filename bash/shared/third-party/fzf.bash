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

  shopt -s inherit_errexit
  shopt -s extdebug
  IFS=$(printf '\n\t')
fi
# END Bash strict mode

### Fuzzy search terminal utilities

if command_exists fzf; then
  export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --bind='ctrl-space:toggle' --ansi"

  export FZF_CTRL_T_OPTS="--select-1 --exit-0"

  export FZF_ALT_C_OPTS="--select-1 --exit-0"

  if command_exists fd; then
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --color=always'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  eval "$(fzf --bash)"

  # Emojis
  function femo() {
    local selected_emoji
    local the_file
    the_file="$(xdg_base_dir DOTFILES || true)/bin/emojis.txt"
    if [[ -f ${the_file} ]]; then
      # shellcheck disable=2002
      selected_emoji=$(cat "${the_file}" | fzf)
    fi
    if [[ -n ${selected_emoji} ]]; then
      echo "${selected_emoji}"
    fi
  }

  # Git ignore

  function __gi() {
    curl -L -s "https://www.gitignore.io/api/$1"
  }

  function gi() {
    if [[ "$#" -eq 0 ]]; then
      IFS+=","
      for item in $(__gi list); do
        echo "${item}"
      done | fzf --multi --ansi | paste -s -d "," - \
        | { read -r result && __gi "${result}"; }
    else
      __gi "$@"
    fi
  }
fi
