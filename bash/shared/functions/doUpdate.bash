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

function _write_msg() {
  local bold
  local reset
  local green
  local t_cols
  t_cols=$(tput cols)
  t_cols=$((t_cols - 1))
  reset="$(tput sgr0)"
  bold="$(tput bold)"
  green="$(tput setaf 2)"
  echo -e "${bold}${green}$1${reset}" | fold -sw "${t_cols}"
}

function doUpdate() {
  if command_exists apt-get
  then
    _write_msg "Getting updates with apt"
    DEBIAN_FRONTEND=noninteractive sudo apt-get -y -q update
    DEBIAN_FRONTEND=noninteractive sudo apt-get -y -q full-upgrade
    DEBIAN_FRONTEND=noninteractive sudo apt-get -y -q autoremove
  fi

  if command_exists flatpak
  then
    _write_msg "Getting updates with flatpak"
    flatpak upgrade -y --noninteractive --system
    flatpak upgrade -y --noninteractive --user
  fi

  if command_exists snap
  then
    _write_msg "Getting updates with snap"
    sudo snap refresh
  fi

  if command_exists pipx
  then
    _write_msg "Getting updates with pipx"
    pipx upgrade-all
  fi

  if command_exists asdf
  then
    _write_msg "Updating plugins for asdf"
    asdf plugin update --all
  fi

  # Record last update
  date +"%Y-%m-%d %r" >> "${HOME}/.cache/updates.txt"
}

alias doup=doUpdate
