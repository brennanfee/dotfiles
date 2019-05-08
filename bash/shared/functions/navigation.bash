#!/usr/bin/env bash

# Some quick navigations within my profile path, largely managed by
# the xdg-user-dir system.  See the ~/.config/user-dirs.dirs file for
# their locations.

# Helper function the others will use
function xdg-cd() {
  local path
  path=$(xdg-user-dir "$1")
  if [[ -d "$path" ]]; then
    cd "$path" || return
  else
    cd "$HOME" || return
  fi
}

function xdg-cd-sub() {
  local path
  local sub
  local sub2
  path=$(xdg-user-dir "$1")
  if [[ -d "$path" ]]; then
    sub="$path/$2"
    sub2="$path/$3"
    if [[ -d "$sub" ]]; then
      cd "$sub" || return
    else
      if [[ -d "$sub2" ]]; then
        cd "$sub2" || return
      else
        cd "$path" || return
      fi
    fi
  else
    cd "$HOME" || return
  fi
}

# Profile folder
function cdp() {
  cd "$(xdg-user-dir PROFILE)" || return
  #xdg-cd "PROFILE"
}

# Desktop folder
function cdk() {
  cd "$(xdg-user-dir DESKTOP)" || return
  #xdg-cd "DESKTOP"
}

# Templates folder
function cdl() {
  cd "$(xdg-user-dir TEMPLATES)" || return
  #xdg-cd "TEMPLATES"
}

# Source folder
function cds() {
  cd "$(xdg-user-dir SOURCE)" || return
  #xdg-cd "SOURCE"
}

# Personal source folder (usually only there on my work machines)
function cdss() {
  xdg-cd-sub "SOURCE" "personal" "Personal"
}

# Github source folder (source projects I pull directly from Github)
# In truth this is also where I pull BitBucket or GitLab public projects
function cdsg() {
  xdg-cd-sub "SOURCE" "github" "Github"
}

# Downloads folder
function cdd() {
  cd "$(xdg-user-dir DOWNLOAD)" || return
  #xdg-cd "DOWNLOAD"
}

# Install folder
function cdi() {
  local path
  local sub
  local sub2
  path=$(xdg-user-dir INSTALLS)
  if [[ -d "$path" ]]; then
    cd "$path" || return
  else
    path=$(xdg-user-dir DOWNLOAD)
    if [[ -d "$path" ]]; then
      sub="$path/installs"
      sub2="$path/Installs"
      if [[ -d "$sub" ]]; then
        cd "$sub" || return
      else
        if [[ -d "$sub2" ]]; then
          cd "$sub2" || return
        else
          cd "$path" || return
        fi
      fi
    else
      cd "$HOME" || return
    fi
  fi
}

# Dotfiles folder
function cdt() {
  if [[ -d "$HOME/.dotfiles" ]]; then
    cd "$HOME/.dotfiles" || return
  else
    cd "$HOME" || return
  fi
}

# Private dotfiles folder
function cdtp() {
  if [[ -d "$HOME/.dotfiles-private" ]]; then
    cd "$HOME/.dotfiles-private" || return
  else
    cdt
  fi
}

# Music folder
function cdm() {
  cd "$(xdg-user-dir MUSIC)" || return
  #xdg-cd "MUSIC"
}

# Music playlist folder
function cdmp() {
  xdg-cd-sub "MUSIC" "playlists" "Playlists"
}

# Mounts folder
function cdmt() {
  cd "$(xdg-user-dir MOUNTS)" || return
  #xdg-cd "MOUNTS"
}

# Videos folder
function cdv() {
  cd "$(xdg-user-dir VIDEOS)" || return
  #xdg-cd "VIDEOS"
}

# VMs folder
function cdvm() {
  cd "$(xdg-user-dir VMS)" || return
  #xdg-cd "VMS"
}

# Dropbox
function cddb() {
  cd "$(xdg-user-dir DROPBOX)" || return
  #xdg-cd "DROPBOX"
}

# Documents or "My Documents"
function cdc() {
  cd "$(xdg-user-dir DOCUMENTS)" || return
  #xdg-cd "DOCUMENTS"
}

# Pictures or Photos
function cdx() {
  cd "$(xdg-user-dir PICTURES)" || return
  #xdg-cd "PICTURES"
}

# "Alternate" home, or Windows home - will only be different than $HOME on Windows
function cdh() {
  if [[ "${WIN_HOME}x" != "x" && -d $WIN_HOME ]]; then
    cd "$WIN_HOME" || return
  else
    cd "$HOME" || return
  fi
}

# Jump to the "winfiles"... otherwise "dotfiles"
function cdw() {
  local profilePath
  profilePath=$(xdg-user-dir PROFILE)
  if [[ -d $profilePath && -d "$profilePath/winfiles" ]]; then
    cd "$profilePath/winfiles" || return
  else
    cdt
  fi
}

# The root of the current git project
alias cdr="cd-to-git-root-path"
