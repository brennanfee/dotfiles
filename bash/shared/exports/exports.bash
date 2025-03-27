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

# Set temps, for consistency
if [[ -d /tmp ]]; then
  export TMP="/tmp"
  export TEMP="/tmp"
  export TMPDIR="/tmp"
fi

# Set languages
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"

# Timezone
export TZ="America/Chicago"

# Set terminal
export TERM=tmux-256color

# Turn on colors
export CLICOLOR=1
export LS_OPTIONS="-hv --color=auto --group-directories-first --time-style=long-iso"

# shellcheck disable=SC2154
export SUDO_PROMPT="${i_fa_lock} password for %u@%h: "

# Suffixes to ignore for filename completion
export FIGNORE=".git:.DS_Store"

# Input
INPUTRC="$(xdg_base_dir CONFIG)/readline/inputrc"
export INPUTRC

# gnupg
GNUPGHOME="$(xdg_base_dir DATA)/gnupg"
export GNUPGHOME
