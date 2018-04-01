#!/usr/bin/env bash

function SetVirtualizationEnvironmentVariables() {
    if [[ $(systemd-detect-virt --vm) == "none" ]]; then
        export IS_VM="false"
    else
        export IS_VM="true"
    fi

    if [[ $(systemd-detect-virt --container) == "none" ]]; then
        export IS_CONTAINER="false"
    else
        export IS_CONTAINER="true"
    fi

    if [[ $(systemd-detect-virt) == "none" ]]; then
        export IS_VIRTUAL="false"
    else
        export IS_VIRTUAL="true"
    fi

    export VIRT_TECH="$(systemd-detect-virt)"

    if [[ "$(cat /etc/passwd | grep -i '^vagrant')x" == "x" ]]; then
        export IS_VAGRANT="false"
    else
        export IS_VAGRANT="true"
    fi
}

# Function that sets two environment variables to indicate the
# type of machine we are on.
function SetOsEnvironmentVariables {
    local uname=$(uname -s | tr '[:upper:]' '[:lower:]')
    if [[ $uname == "darwin" ]]; then
        export OS_PRIMARY="macos"
        export OS_SECONDARY="macos"
    elif [[ $uname == "linux" ]]; then
        local ver=$(cat /proc/version | tr '[:upper:]' '[:lower:]')
        export OS_PRIMARY="linux"
        if [[ $ver == *"-arch"* ]]; then
            export OS_SECONDARY="arch"
        elif [[ $ver == *".centos.org"* ]]; then
            export OS_SECONDARY="centos"
        elif [[ $ver == *".fedoraproject.org"* ]]; then
            export OS_SECONDARY="fedora"
        elif [[ $ver == *"-kalil"* ]]; then
            export OS_SECONDARY="kali"
        elif [[ $ver == *"(suse "* ]]; then
            export OS_SECONDARY="suse"
        elif [[ $ver == *"(ubuntu "* ]]; then
            export OS_SECONDARY="ubuntu"
        elif [[ $ver == *"(debian "* ]]; then
            export OS_SECONDARY="debian"
        elif [[ $ver == *"(microsoft"* ]]; then
            export OS_SECONDARY="windows"
        else
            export OS_SECONDARY="unknown"
        fi
    elif [[ $uname == "freebsd" ]]; then
        export OS_PRIMARY="bsd"
        export OS_SECONDARY="freebsd"
    elif [[ $uname == "openbsd" ]]; then
        export OS_PRIMARY="bsd"
        export OS_SECONDARY="openbsd"
    else
        export OS_PRIMARY="unknown"
        export OS_SECONDARY="unknown"
    fi

    SetVirtualizationEnvironmentVariables
}

function is_mac {
    return [[ $OS_PRIMARY == "macos" ]]
}

function is_linux {
    return [[ $OS_PRIMARY == "linux" ]]
}

function is_windows {
    return [[ $OS_PRIMARY == "windows" ]]
}

# Function to easily add a path (this version adds to the end)
# http://superuser.com/a/39995
function path_append {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
      export PATH="${PATH:+"$PATH:"}$1"
  fi
}

function manpath_append {
  if [[ -d "$1" ]] && [[ ":$MANPATH:" != *":$1:"* ]]; then
      export MANPATH="${MANPATH:+"$MANPATH:"}$1"
  fi
}

# Function to easily add a path (this version adds to the beginning)
# http://superuser.com/a/39995
function path_prepend {
  if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]]; then
      export PATH="$1:$PATH"
  fi
}

function manpath_prepend {
  if [[ -d "$1" ]] && [[ ":$MANPATH:" != *":$1:"* ]]; then
      export MANPATH="$1:$MANPATH"
  fi
}

# function to make sourcing an optional item easier
function source_if {
    if [[ -f "$1" ]]; then
        source "$1"
    fi
}

# function to make checking executable existence easier
function command_exists {
    command -v "$1" &> /dev/null && return 0 || return 1
}

