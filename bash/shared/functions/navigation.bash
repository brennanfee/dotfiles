#!/usr/bin/env bash

# Some quick navigations within my profile path, largely managed by
# the xdg-user-dir system.  See the ~/.config/user-dirs.dirs file for
# their locations.

# Helper function the others will use
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
}

# Desktop folder
function cdk() {
  cd "$(xdg-user-dir DESKTOP)" || return
}

# Templates folder
function cdl() {
  cd "$(xdg-user-dir TEMPLATES)" || return
}

# Source folder
function cds() {
  cd "$(xdg-user-dir SOURCE)" || return
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
}

# Music playlist folder
function cdmp() {
  xdg-cd-sub "MUSIC" "playlists" "Playlists"
}

# Mounts folder
function cdmt() {
  cd "$(xdg-user-dir MOUNTS)" || return
}

# Videos folder
function cdv() {
  cd "$(xdg-user-dir VIDEOS)" || return
}

# VMs folder
function cdvm() {
  cd "$(xdg-user-dir VMS)" || return
}

# Dropbox
function cddb() {
  cd "$(xdg-user-dir DROPBOX)" || return
}

# Cloud folder, intended as the cloud shared\synced folder
function cdc() {
  cd "$(xdg-user-dir CLOUD)" || cd "$(xdg-user-dir DROPBOX)" || return
}

# Documents or "My Documents"
function cdoc() {
  cd "$(xdg-user-dir DOCUMENTS)" || return
}

# Pictures or Photos
function cdx() {
  cd "$(xdg-user-dir PICTURES)" || return
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
