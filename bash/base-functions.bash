#!/usr/bin/env bash

# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# Function that sets two environment variables to indicate the
# type of machine we are on.
function SetOsEnvironmentVariables {
    local uname=$(uname -s)
    if [[ $uname == "Darwin" ]]; then
        export OS_PRIMARY="macos"
        export OS_SECONDARY="macos"
    elif [[ $uname == "Linux" ]]; then
        local ver=$(cat /proc/version)
        if [[ $ver == *"-ARCH"* ]]; then
            export OS_PRIMARY="linux"
            export OS_SECONDARY="arch"
        elif [[ $ver == *".centos.org"* ]]; then
            export OS_PRIMARY="linux"
            export OS_SECONDARY="centos"
        elif [[ $ver == *".fedoraproject.org"* ]]; then
            export OS_PRIMARY="linux"
            export OS_SECONDARY="fedora"
        elif [[ $ver == *"-kalil"* ]]; then
            export OS_PRIMARY="linux"
            export OS_SECONDARY="kali"
        elif [[ $ver == *"(SUSE "* ]]; then
            export OS_PRIMARY="linux"
            export OS_SECONDARY="suse"
        elif [[ $ver == *"(Ubuntu "* ]]; then
            export OS_PRIMARY="linux"
            export OS_SECONDARY="ubuntu"
        elif [[ $ver == *"(Debian "* ]]; then
            export OS_PRIMARY="linux"
            export OS_SECONDARY="debian"
        elif [[ $ver == *"(Microsoft@Microsoft"* ]]; then
            export OS_PRIMARY="windows"
            export OS_SECONDARY="windows"
        else
            export OS_PRIMARY="linux"
            export OS_SECONDARY="unknown"
        fi
    else
        export OS_PRIMARY="unknown"
        export OS_SECONDARY="unknown"
    fi
}

# Function to easily add a path (this version adds to the end)
# http://superuser.com/a/39995
function path_append {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
      export PATH="${PATH:+"$PATH:"}$1"
  fi
}

# Function to easily add a path (this version adds to the beginning)
# http://superuser.com/a/39995
function path_prepend {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
      export PATH="$1:$PATH"
  fi
}

# Function to make sourcing an optional item easier
function source_if {
    [[ -f "$1" ]] && source "$1"
}
