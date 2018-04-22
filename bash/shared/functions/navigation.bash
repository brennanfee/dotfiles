#!/usr/bin/env bash

# Set the base of my profile (this is where I create folders for normal use)
export MY_PROFILE=$HOME
# This is only here for Windows and WSL.  For all non-Windows machines HOME is home, but for
# the WSL shell home is the unix home and OS_HOME gets set to the machines user
# profile (/mnt/c/Users/<name>).  This allows cd on its own to take you to the unix home but cdh
# to take you to the "windows" home.  On a linux box cdh is equivelant to cd.
export OS_HOME=$HOME

# Some quick navigations
function cdp() {
    if [[ -d "$MY_PROFILE/projects" ]]; then
        cd "$MY_PROFILE/projects"
    elif [[ -d "$MY_PROFILE/Projects" ]]; then
        cd "$MY_PROFILE/Projects"
    else
        cd "$MY_PROFILE"
    fi
}

function cdpp() {
    if [[ -d "$MY_PROFILE/projects" ]]; then
        if [[ -d "$MY_PROFILE/projects/personal" ]]; then
            cd "$MY_PROFILE/projects/personal"
        elif [[ -d "$MY_PROFILE/projects/Personal" ]]; then
            cd "$MY_PROFILE/projects/Personal"
        else
            cd "$MY_PROFILE/projects"
        fi
    elif [[ -d "$MY_PROFILE/Projects" ]]; then
        if [[ -d "$MY_PROFILE/Projects/personal" ]]; then
            cd "$MY_PROFILE/Projects/personal"
        elif [[ -d "$MY_PROFILE/Projects/Personal" ]]; then
            cd "$MY_PROFILE/Projects/Personal"
        else
            cd "$MY_PROFILE/Projects"
        fi
    else
        cd "$MY_PROFILE"
    fi
}

function cdd() {
    if [[ -d "$MY_PROFILE/downloads" ]]; then
        cd "$MY_PROFILE/downloads"
    elif [[ -d "$MY_PROFILE/Downloads" ]]; then
        cd "$MY_PROFILE/Downloads"
    else
        cd "$MY_PROFILE"
    fi
}

function cdi() {
    if [[ -d "$MY_PROFILE/installs" ]]; then
        cd "$MY_PROFILE/installs"
    elif [[ -d "$MY_PROFILE/Installs" ]]; then
        cd "$MY_PROFILE/Installs"
    elif [[ -d "$MY_PROFILE/downloads/installs" ]]; then
        cd "$MY_PROFILE/downloads/installs"
    elif [[ -d "$MY_PROFILE/downloads/Installs" ]]; then
        cd "$MY_PROFILE/downloads/Installs"
    elif [[ -d "$MY_PROFILE/Downloads/installs" ]]; then
        cd "$MY_PROFILE/Downloads/installs"
    elif [[ -d "$MY_PROFILE/Downloads/Installs" ]]; then
        cd "$MY_PROFILE/Downloads/Installs"
    elif [[ -d "$MY_PROFILE/downloads" ]]; then
        cd "$MY_PROFILE/downloads"
    elif [[ -d "$MY_PROFILE/Downloads" ]]; then
        cd "$MY_PROFILE/Downloads"
    else
        cd "$MY_PROFILE"
    fi
}

function cdt() {
    if [[ -d "$HOME/.dotfiles" ]]; then
        cd "$HOME/.dotfiles"
    else
        cd "$HOME"
    fi
}

function cdm() {
    if [[ -d "$MY_PROFILE/music" ]]; then
        cd "$MY_PROFILE/music"
    elif [[ -d "$MY_PROFILE/Music" ]]; then
        cd "$MY_PROFILE/Music"
    else
        cd "$MY_PROFILE"
    fi
}

function cdv() {
    if [[ -d "$MY_PROFILE/videos" ]]; then
        cd "$MY_PROFILE/videos"
    elif [[ -d "$MY_PROFILE/Videos" ]]; then
        cd "$MY_PROFILE/Videos"
    else
        cd "$MY_PROFILE"
    fi
}

function cdb() {
    if [[ -d "$MY_PROFILE/dropbox" ]]; then
        cd "$MY_PROFILE/dropbox"
    elif [[ -d "$MY_PROFILE/Dropbox" ]]; then
        cd "$MY_PROFILE/Dropbox"
    else
        cd "$MY_PROFILE"
    fi
}

function cdc() {
    if [[ -d "$MY_PROFILE/documents" ]]; then
        cd "$MY_PROFILE/documents"
    elif [[ -d "$MY_PROFILE/Documents" ]]; then
        cd "$MY_PROFILE/Documents"
    else
        cd "$MY_PROFILE"
    fi
}

function cdx() {
    if [[ -d "$MY_PROFILE/pictures" ]]; then
        cd "$MY_PROFILE/pictures"
    elif [[ -d "$MY_PROFILE/Pictures" ]]; then
        cd "$MY_PROFILE/Pictures"
    else
        cd "$MY_PROFILE"
    fi
}

function cdh() {
    if [[ -d $OS_HOME ]]; then
        cd "$OS_HOME"
    else
        cd "$HOME"
    fi
}

alias cdr="cd-to-git-root-path"
