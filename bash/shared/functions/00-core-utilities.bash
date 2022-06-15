#!/usr/bin/env bash

function is_mac() {
  if [[ ${OS_PRIMARY:-linux} == "macos" ]]; then
    return 0
  else
    return 1
  fi
}

function is_linux() {
  if [[ ${OS_PRIMARY:-linux} == "linux" ]]; then
    return 0
  else
    return 1
  fi
}

function is_windows() {
  if [[ ${IS_WSL:-false} == "true" ]]; then
    return 0
  else
    return 1
  fi
}

# Function to easily add a path (this version adds to the end)
# http://superuser.com/a/39995
function path_append() {
  if [[ -d $1 ]] && [[ ":${PATH}:" != *":$1:"* ]]; then
    export PATH="${PATH:+"${PATH}:"}$1"
  fi
}

function manpath_append() {
  if [[ -d $1 ]] && [[ ":${MANPATH}:" != *":$1:"* ]]; then
    export MANPATH="${MANPATH:+"${MANPATH}:"}$1"
  fi
}

# Function to easily add a path (this version adds to the beginning)
# http://superuser.com/a/39995
function path_prepend() {
  if [[ -d $1 ]] && [[ ":${PATH}:" != *":$1:"* ]]; then
    export PATH="$1:${PATH}"
  fi
}

function manpath_prepend() {
  if [[ -d $1 ]] && [[ ":${MANPATH}:" != *":$1:"* ]]; then
    export MANPATH="$1:${MANPATH}"
  fi
}

# function to make sourcing an optional item easier
function source_if() {
  if [[ -f $1 ]]; then
    # shellcheck source=/dev/null
    source "$1"
  fi
}

# function to make checking executable existence easier
function command_exists() {
  command -v "$1" &>/dev/null && return 0 || return 1
}
