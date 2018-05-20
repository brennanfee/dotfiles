#!/usr/bin/env bash

# Some quick navigations within my profile path

# Projects folder
function cdp() {
    if [[ -d "$MY_PROFILE/projects" ]]; then
        cd "$MY_PROFILE/projects" || return
    elif [[ -d "$MY_PROFILE/Projects" ]]; then
        cd "$MY_PROFILE/Projects" || return
    else
        cd "$MY_PROFILE" || return
    fi
}

# Personal projects folder
function cdpp() {
    if [[ -d "$MY_PROFILE/projects" ]]; then
        if [[ -d "$MY_PROFILE/projects/personal" ]]; then
            cd "$MY_PROFILE/projects/personal" || return
        elif [[ -d "$MY_PROFILE/projects/Personal" ]]; then
            cd "$MY_PROFILE/projects/Personal" || return
        else
            cd "$MY_PROFILE/projects" || return
        fi
    elif [[ -d "$MY_PROFILE/Projects" ]]; then
        if [[ -d "$MY_PROFILE/Projects/personal" ]]; then
            cd "$MY_PROFILE/Projects/personal" || return
        elif [[ -d "$MY_PROFILE/Projects/Personal" ]]; then
            cd "$MY_PROFILE/Projects/Personal" || return
        else
            cd "$MY_PROFILE/Projects" || return
        fi
    else
        cd "$MY_PROFILE" || return
    fi
}

# Downloads folder
function cdd() {
    if [[ -d "$MY_PROFILE/downloads" ]]; then
        cd "$MY_PROFILE/downloads" || return
    elif [[ -d "$MY_PROFILE/Downloads" ]]; then
        cd "$MY_PROFILE/Downloads" || return
    else
        cd "$MY_PROFILE" || return
    fi
}

# Install folder
function cdi() {
    if [[ -d "$MY_PROFILE/installs" ]]; then
        cd "$MY_PROFILE/installs" || return
    elif [[ -d "$MY_PROFILE/Installs" ]]; then
        cd "$MY_PROFILE/Installs" || return
    elif [[ -d "$MY_PROFILE/downloads/installs" ]]; then
        cd "$MY_PROFILE/downloads/installs" || return
    elif [[ -d "$MY_PROFILE/downloads/Installs" ]]; then
        cd "$MY_PROFILE/downloads/Installs" || return
    elif [[ -d "$MY_PROFILE/Downloads/installs" ]]; then
        cd "$MY_PROFILE/Downloads/installs" || return
    elif [[ -d "$MY_PROFILE/Downloads/Installs" ]]; then
        cd "$MY_PROFILE/Downloads/Installs" || return
    else
        cdd
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
    if [[ -d "$MY_PROFILE/music" ]]; then
        cd "$MY_PROFILE/music" || return
    elif [[ -d "$MY_PROFILE/Music" ]]; then
        cd "$MY_PROFILE/Music" || return
    else
        cd "$MY_PROFILE" || return
    fi
}

# Music playlist folder
function cdmp() {
    if [[ -d "$MY_PROFILE/music/playlists" ]]; then
        cd "$MY_PROFILE/music/playlists" || return
    elif [[ -d "$MY_PROFILE/music/Playlists" ]]; then
        cd "$MY_PROFILE/music/Playlists" || return
    elif [[ -d "$MY_PROFILE/Music/playlists" ]]; then
        cd "$MY_PROFILE/Music/playlists" || return
    elif [[ -d "$MY_PROFILE/Music/Playlists" ]]; then
        cd "$MY_PROFILE/Music/Playlists" || return
    else
        cdm
    fi
}

# Videos folder
function cdv() {
    if [[ -d "$MY_PROFILE/videos" ]]; then
        cd "$MY_PROFILE/videos" || return
    elif [[ -d "$MY_PROFILE/Videos" ]]; then
        cd "$MY_PROFILE/Videos" || return
    else
        cd "$MY_PROFILE" || return
    fi
}

# Dropbox
function cdb() {
    if [[ -d "$MY_PROFILE/dropbox" ]]; then
        cd "$MY_PROFILE/dropbox" || return
    elif [[ -d "$MY_PROFILE/Dropbox" ]]; then
        cd "$MY_PROFILE/Dropbox" || return
    else
        cd "$MY_PROFILE" || return
    fi
}

# Documents or "My Documents"
function cdc() {
    if [[ -d "$MY_PROFILE/documents" ]]; then
        cd "$MY_PROFILE/documents" || return
    elif [[ -d "$MY_PROFILE/Documents" ]]; then
        cd "$MY_PROFILE/Documents" || return
    else
        cd "$MY_PROFILE" || return
    fi
}

# Pictures or Photos
function cdx() {
    if [[ -d "$MY_PROFILE/pictures" ]]; then
        cd "$MY_PROFILE/pictures" || return
    elif [[ -d "$MY_PROFILE/Pictures" ]]; then
        cd "$MY_PROFILE/Pictures" || return
    else
        cd "$MY_PROFILE" || return
    fi
}

# "Alternate" home, or Windows home - will only be different than $HOME on Windows
function cdh() {
    if [[ "${WIN_HOME}x" != "x" && -d "$WIN_HOME" ]]; then
        cd "$WIN_HOME" || return
    else
        cd "$HOME" || return
    fi
}

# The root of the current git project
alias cdr="cd-to-git-root-path"
