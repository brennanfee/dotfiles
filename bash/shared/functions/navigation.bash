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

profile_path=$(xdg-user-dir PROFILE)

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
      cd "${sub}" || return
    else
      if [[ -d "${sub2}" ]]; then
        cd "${sub2}" || return
      else
        cd "${the_path}" || return
      fi
    fi
  else
    cdp
  fi
}

function xdg-go-to-dir() {
  local the_path
  the_path=$(xdg-user-dir "$1")
  the_path="${the_path:-$2}"
  if [[ -d ${the_path} ]]; then
    cd "${the_path}" || return
  else
    cdp
  fi
}

# Profile folder
function cdp() {
  if [[ -d ${profile_path} ]]; then
    cd "${profile_path}" || return
  else
    cd "${HOME}" || return
  fi
}

# Desktop folder
function cdsk() {
  xdg-go-to-dir "DESKTOP" "${HOME}/Desktop"
}
#alias cdk=cdsk

# Templates folder
function cdl() {
  xdg-go-to-dir "TEMPLATES" "${profile_path}/templates"
}
alias cdtm=cdl

# Source folder
function cds() {
  xdg-go-to-dir "SOURCE" "${profile_path}/source"
}

# Personal source folder (usually only there on my work machines)
function cdss() {
  xdg-cd-sub "SOURCE" "${profile_path}/source" "personal" "Personal"
}
alias cdsp=cdss

# Github source folder (source projects I pull directly from Github)
# In truth this is also where I pull BitBucket or GitLab public projects
function cdsg() {
  xdg-cd-sub "SOURCE" "${profile_path}/source" "github" "Github"
}

# Downloads folder
function cdd() {
  xdg-go-to-dir "DOWNLOAD" "${profile_path}/downloads"
}

# Install folder
function cdi() {
  local the_path
  the_path=$(xdg-user-dir INSTALLS)
  the_path="${the_path:-${profile_path/installs}}"
  if [[ -d "${the_path}" ]]; then
    cd "${the_path}" || return
  else
    xdg-cd-sub "DOWNLOAD" "${profile_path}/downloads" "installs" "Installs"
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

# Music folder
function cdm() {
  xdg-go-to-dir "MUSIC" "${profile_path}/music"
}

# Music playlist folder
function cdmp() {
  xdg-cd-sub "MUSIC" "${profile_path}/music" "playlists" "Playlists"
}
alias cdpl="cdmp"

# Mounts folder
function cdmt() {
  xdg-go-to-dir "MOUNTS" "${profile_path}/mounts"
}

# Main files folder (mounted from a network share)
function cdf() {
  xdg-cd-sub "MOUNTS" "${profile_path}/mounts" "moose" "moose"
}

# Videos folder
function cdv() {
  xdg-go-to-dir "VIDEOS" "${profile_path}/videos"
}

# VMs folder
function cdvm() {
  xdg-go-to-dir "VMS" "${profile_path}/vms"
}

# Cloud folder, intended as the cloud shared\synced folder
function cdc() {
  xdg-go-to-dir "CLOUD" "${profile_path}/cloud"
}

# Documents or "My Documents"
function cdoc() {
  xdg-go-to-dir "DOCUMENTS" "${profile_path}/documents"
}
alias cdo=cdoc

# Pictures or Photos
function cdx() {
  xdg-go-to-dir "PICTURES" "${profile_path}/pictures"
}
alias cdpx=cdx

# Home alias, some linux systems require typing "cd -" to go home.  This replaces that.
function cdh() {
  cd "${HOME}" || return
}

# "Alternate" home, or Windows home - will only be different than $HOME on Windows
function cdhh() {
  if [[ "${WIN_HOME:-}" != "" && -d ${WIN_HOME} ]]; then
    cd "${WIN_HOME}" || return
  else
    cd "${HOME}" || return
  fi
}
alias cdwh=cdhh

# Jump to the "winfiles"... otherwise "dotfiles"
function cdw() {
  if [[ -d ${profile_path} && -d "${profile_path}/winfiles" ]]; then
    cd "${profile_path}/winfiles" || return
  else
    cdt
  fi
}

# The root of the current git project
alias cdr="cd-to-git-root-path"

unset profile_path
