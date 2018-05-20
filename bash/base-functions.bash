#!/usr/bin/env bash

# Function that sets two environment variables to indicate the
# type of machine we are on.
function SetOsEnvironmentVariables() {
    local uname
    uname=$(uname -s | tr '[:upper:]' '[:lower:]')
    if [[ $uname == "darwin" ]]; then
        export OS_PRIMARY="macos"
        export OS_SECONDARY="macos"
    elif [[ $uname == "linux" ]]; then
        export OS_PRIMARY="linux"
        export OS_SECONDARY
        OS_SECONDARY=$(grep -i '^ID=' </etc/os-release | sed -e 's/^ID=//' | tr '[:upper:]' '[:lower:]')
        if [[ "${OS_SECONDARY}x" == "x" ]]; then
            OS_SECONDARY="unknown"
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

    # Also check to see if we are runnin on Windows in WSL
    local kernel
    kernel=$(uname -r | tr '[:upper:]' '[:lower:]')
    if [[ $kernel == *"microsoft"* ]]; then
        export IS_WSL="true"
    else
        export IS_WSL="false"
    fi
}

function is_mac() {
    if [[ $OS_PRIMARY == "macos" ]]; then
        return 0
    else
        return 1
    fi
}

function is_linux() {
    if [[ $OS_PRIMARY == "linux" ]]; then
        return 0
    else
        return 1
    fi
}

function is_windows() {
    if [[ $IS_WSL == "true" ]]; then
        return 0
    else
        return 1
    fi
}

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

    local VIRT_TECH
    VIRT_TECH="$(systemd-detect-virt)"
    export VIRT_TECH

    if [[ "$(grep -i '^vagrant' </etc/passwd)x" == "x" ]]; then
        export IS_VAGRANT="false"
    else
        export IS_VAGRANT="true"
    fi
}

# Function to easily add a path (this version adds to the end)
# http://superuser.com/a/39995
function path_append() {
    if [[ -d $1 ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="${PATH:+"$PATH:"}$1"
    fi
}

function manpath_append() {
    if [[ -d $1 ]] && [[ ":$MANPATH:" != *":$1:"* ]]; then
        export MANPATH="${MANPATH:+"$MANPATH:"}$1"
    fi
}

# Function to easily add a path (this version adds to the beginning)
# http://superuser.com/a/39995
function path_prepend() {
    if [[ -d $1 ]] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

function manpath_prepend() {
    if [[ -d $1 ]] && [[ ":$MANPATH:" != *":$1:"* ]]; then
        export MANPATH="$1:$MANPATH"
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
