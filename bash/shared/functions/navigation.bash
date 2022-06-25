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

# Some quick navigations within my profile path, largely managed by
# the xdg-user-dir system.  See the ~/.config/user-dirs.dirs file for
# their locations.

# Helper functions the others will use
function xdg-cd-sub() {
  local the_path
  local sub
  local sub2
  the_path=$(xdg-user-dir "$1")
  the_path="${the_path:-$2}"
  if [[ -d "${the_path}" ]]; then
    sub="${the_path}/$3"
    sub2="${the_path}/$4"
    if [[ -d "${sub}" ]]; then
      builtin cd "${sub}" || return
    else
      if [[ -d "${sub2}" ]]; then
        builtin cd "${sub2}" || return
      else
        builtin cd "${the_path}" || return
      fi
    fi
  else
    cdp
  fi
}

function xdg-go-to-dir() {
  local the_path
  the_path=$(xdg-base-dir "$1")
  the_path="${the_path:-$2}"
  if [[ -d ${the_path} ]]; then
    builtin cd "${the_path}" || return
  else
    cdp
  fi
}

# Profile folder
function cdp() {
  if [[ -d ${PROFILEPATH} ]]; then
    builtin cd "${PROFILEPATH}" || return
  else
    builtin cd "${HOME}" || return
  fi
}

# Desktop folder
function cdsk() {
  xdg-go-to-dir "DESKTOP" "${HOME}/Desktop"
}
#alias cdk=cdsk

# Templates folder
function cdl() {
  xdg-go-to-dir "TEMPLATES" "${PROFILEPATH}/templates"
}
alias cdtm=cdl

# Source folder
function cds() {
  xdg-go-to-dir "SOURCE" "${PROFILEPATH}/source"
}

# Personal source folder (usually only there on my work machines)
function cdss() {
  xdg-cd-sub "SOURCE" "${PROFILEPATH}/source" "personal" "Personal"
}
alias cdsp=cdss

# Github source folder (source projects I pull directly from Github)
# In truth this is also where I pull BitBucket or GitLab public projects
function cdsg() {
  xdg-cd-sub "SOURCE" "${PROFILEPATH}/source" "github" "Github"
}

# Downloads folder
function cdd() {
  xdg-go-to-dir "DOWNLOAD" "${PROFILEPATH}/downloads"
}

# Install folder
function cdi() {
  local the_path
  the_path=$(xdg-user-dir INSTALLS)
  the_path="${the_path:-${PROFILEPATH/installs}}"
  if [[ -d "${the_path}" ]]; then
    builtin cd "${the_path}" || return
  else
    xdg-cd-sub "DOWNLOAD" "${PROFILEPATH}/downloads" "installs" "Installs"
  fi
}
alias cddi=cdi

# Dotfiles folder
function cdt() {
  xdg-go-to-dir "DOTFILES" "${HOME}/.dotfiles"
}

# Private dotfiles folder
function cdtp() {
  xdg-go-to-dir "DOTFILESPRIVATE" "${HOME}/.dotfiles-private"
}

# Dotfiles bin
function cdtb() {
  xdg-cd-sub "DOTFILES" "${HOME}/.dotfiles" "bin" "bin"
}

# User Bin folder
function cdb() {
  xdg-go-to-dir "BIN" "${HOME}/.local/bin"
}

# Music folder
function cdm() {
  xdg-go-to-dir "MUSIC" "${PROFILEPATH}/music"
}

# Music playlist folder
function cdmp() {
  xdg-cd-sub "MUSIC" "${PROFILEPATH}/music" "playlists" "Playlists"
}
alias cdpl="cdmp"

# Mounts folder
function cdmt() {
  xdg-go-to-dir "MOUNTS" "${PROFILEPATH}/mounts"
}

# Main files folder (mounted from a network share)
function cdf() {
  xdg-cd-sub "MOUNTS" "${PROFILEPATH}/mounts" "moose" "moose"
}

# Videos folder
function cdv() {
  xdg-go-to-dir "VIDEOS" "${PROFILEPATH}/videos"
}

# VMs folder
function cdvm() {
  xdg-go-to-dir "VMS" "${PROFILEPATH}/vms"
}

# Cloud folder, intended as the cloud shared\synced folder
function cdc() {
  xdg-go-to-dir "CLOUD" "${PROFILEPATH}/cloud"
}

# Documents or "My Documents"
function cdoc() {
  xdg-go-to-dir "DOCUMENTS" "${PROFILEPATH}/documents"
}
alias cdo=cdoc

# Pictures or Photos
function cdx() {
  xdg-go-to-dir "PICTURES" "${PROFILEPATH}/pictures"
}
alias cdpx=cdx

# Home alias, some linux systems require typing "cd -" to go home.  This replaces that.
function cdh() {
  builtin cd "${HOME}" || return
}
alias cd-=cdh

# "Alternate" home, or Windows home - will only be different than $HOME on Windows
function cdhh() {
  if [[ "${WIN_HOME:-}" != "" && -d ${WIN_HOME} ]]; then
    builtin cd "${WIN_HOME}" || return
  else
    builtin cd "${HOME}" || return
  fi
}
alias cdwh=cdhh

# Jump to the "winfiles"... otherwise "dotfiles"
function cdw() {
  if [[ -d ${PROFILEPATH} && -d "${PROFILEPATH}/winfiles" ]]; then
    builtin cd "${PROFILEPATH}/winfiles" || return
  else
    cdt
  fi
}

# The root of the current git project
alias cdr="cd-to-git-root-path"

# Overide the usual cd command

#cd() {
#  [[ $# -eq 0 ]] && return
#  builtin cd "$@"
#}
