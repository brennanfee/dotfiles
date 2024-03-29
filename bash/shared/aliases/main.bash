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

# Turn on colors
alias ls='ls $LS_OPTIONS'
alias lss='ls -1'
alias dir='ls -CA'
alias vdir='ls -lA'
alias tree="tree -C"

alias grep="grep --color"
alias pgrep="grep --color"
alias egrep="grep --color"

# Make sudo preserve home
alias sudo="sudo -H"
alias se="sudoedit"

# Alternates/extensions of ls
alias la="ls -A"
alias ll="ls -oh"
alias lla="ls -ohA"
alias lls="ls -lhA"
alias ldir='ls -ohA --color=never | grep --color=never "^d"'

alias sl="ls"

# Directory & file
alias md='mkdir -p'
alias mkdir="mkdir -p"

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# DOS like clear
alias cls="clear"

# Vim shell typos
alias :q="exit"
alias :wq="exit"
alias :x="exit"

# History
alias histg='history | grep'
if command_exists rg; then
  alias hist='history | rg'
else
  alias hist='history | grep'
fi

# Utility commands
alias mkdatedir='mkdir $(date "+%Y-%m-%d")'
alias mkdatefile='touch $(date "+%Y-%m-%d").txt'

# CD typos
alias cd.='cd ..'
alias cd..='cd ..'
alias cdu='cd ..'

# RipGrep should always use "smart-case"
if command_exists rg; then
  alias rg='rg -S'
fi

# wget
# shellcheck disable=SC2139
alias wget=wget --hsts-file="$(xdg-base-dir DATA || true)/wget-hsts"

# Set up alias for fd
if command_exists fdfind; then
  alias fd="fdfind"
fi

# If bat is installed, make it cat
if command_exists bat; then
  alias cat="bat"
elif command_exists batcat; then
  alias bat="batcat"
  alias cat="batcat"
else
  alias bat="cat"
fi

if command_exists thefuck; then
  eval "$(thefuck --alias || true)"
fi
