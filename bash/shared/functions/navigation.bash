#!/usr/bin/env bash

# Set the base of my profile (this is where I create folders for normal use)
export MY_PROFILE=$HOME
# This is only here for Windows and WSL.  For all non-Windows machines HOME is home, but for
# the WSL shell home is the unix home and OS_HOME gets set to the machines user
# profile (/mnt/c/Users/<name>).  This allows cd on its own to take you to the unix home but cdh
# to take you to the "windows" home.  On a linux box cdh is equivelant to cd.
export OS_HOME=$HOME

# Some quick navigations
function cdp {
    if [[ -d "$MY_PROFILE/projects" ]]; then
        cd "$MY_PROFILE/projects"
    else
        cd "$MY_PROFILE"
    fi
}

function cdpp {
    if [[ -d "$MY_PROFILE/projects/personal" ]]; then
        cd "$MY_PROFILE/projects/personal"
    else
        if [[ -d "$MY_PROFILE/projects" ]]; then
            cd "$MY_PROFILE/projects"
        else
            cd "$MY_PROFILE"
        fi
    fi
}

function cdd {
    if [[ -d "$MY_PROFILE/downloads" ]]; then
        cd "$MY_PROFILE/downloads"
    else
        cd "$MY_PROFILE"
    fi
}

function cdi {
    cd "$MY_PROFILE/downloads/installs"
    if [[ -d "$MY_PROFILE/downloads/installs" ]]; then
        cd "$MY_PROFILE/downloads/installs"
    else
        if [[ -d "$MY_PROFILE/downloads" ]]; then
            cd "$MY_PROFILE/downloads"
        else
            cd "$MY_PROFILE"
        fi
    fi
}

function cdt {
    if [[ -d "$HOME/.dotfiles" ]]; then
        cd "$HOME/.dotfiles"
    else
        cd "$HOME"
    fi
}

function cdh {
    if [[ -d "$OS_HOME" ]]; then
        cd "$OS_HOME"
    else
        cd "$HOME"
    fi
}

alias cdr="cd-to-git-root-path"

