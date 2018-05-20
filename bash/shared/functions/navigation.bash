#!/usr/bin/env bash

# Some quick navigations within my profile path

# Projects folder
function cdp() {
    if [[ -d "$MY_PROFILE/projects" ]]; then
        cd "$MY_PROFILE/projects"
    elif [[ -d "$MY_PROFILE/Projects" ]]; then
        cd "$MY_PROFILE/Projects"
    else
        cd "$MY_PROFILE"
    fi
}

# Personal projects folder
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

# Downloads folder
function cdd() {
    if [[ -d "$MY_PROFILE/downloads" ]]; then
        cd "$MY_PROFILE/downloads"
    elif [[ -d "$MY_PROFILE/Downloads" ]]; then
        cd "$MY_PROFILE/Downloads"
    else
        cd "$MY_PROFILE"
    fi
}

# Install folder
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

# Dotfiles folder
function cdt() {
    if [[ -d "$HOME/.dotfiles" ]]; then
        cd "$HOME/.dotfiles"
    else
        cd "$HOME"
    fi
}

# Music folder
function cdm() {
    if [[ -d "$MY_PROFILE/music" ]]; then
        cd "$MY_PROFILE/music"
    elif [[ -d "$MY_PROFILE/Music" ]]; then
        cd "$MY_PROFILE/Music"
    else
        cd "$MY_PROFILE"
    fi
}

# Videos folder
function cdv() {
    if [[ -d "$MY_PROFILE/videos" ]]; then
        cd "$MY_PROFILE/videos"
    elif [[ -d "$MY_PROFILE/Videos" ]]; then
        cd "$MY_PROFILE/Videos"
    else
        cd "$MY_PROFILE"
    fi
}

# Dropbox
function cdb() {
    if [[ -d "$MY_PROFILE/dropbox" ]]; then
        cd "$MY_PROFILE/dropbox"
    elif [[ -d "$MY_PROFILE/Dropbox" ]]; then
        cd "$MY_PROFILE/Dropbox"
    else
        cd "$MY_PROFILE"
    fi
}

# Documents or "My Documents"
function cdc() {
    if [[ -d "$MY_PROFILE/documents" ]]; then
        cd "$MY_PROFILE/documents"
    elif [[ -d "$MY_PROFILE/Documents" ]]; then
        cd "$MY_PROFILE/Documents"
    else
        cd "$MY_PROFILE"
    fi
}

# Pictures or Photos
function cdx() {
    if [[ -d "$MY_PROFILE/pictures" ]]; then
        cd "$MY_PROFILE/pictures"
    elif [[ -d "$MY_PROFILE/Pictures" ]]; then
        cd "$MY_PROFILE/Pictures"
    else
        cd "$MY_PROFILE"
    fi
}

# "Alternate" home, or Windows home - will only be different than $HOME on Windows
function cdh() {
    if [[ -z "${WIN_HOME+x}" && -d "$WIN_HOME" ]]; then
        cd "$WIN_HOME"
    else
        cd "$HOME"
    fi
}

# The root of the current git project
alias cdr="cd-to-git-root-path"
