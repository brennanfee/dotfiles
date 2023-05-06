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

if command_exists io.neovim.vim; then
  alias nvim="io.neovim.vim"
fi

if command_exists nvim || command_exists io.neovim.vim; then
  # Setup for nvim
  alias vi="nvim"
  alias v="nvim -R"
  alias view="nvim -R"
else
  # Setup for vim
  alias vi="vim"
  alias v="vim -R"
  alias view="vim -R"
fi

# Editor mappings
alias e='"$EDITOR"'
alias edit='"$EDITOR"'
alias eg='"$VISUAL"'
alias ev='"$VISUAL"'
alias vis='"$VISUAL"'
