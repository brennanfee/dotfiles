#!/usr/bin/env bash

# Set the base of my profile (this is where I create folders for normal use)
export MY_PROFILE=$HOME
# This is only here for Windows and WSL.  For all non-Windows machines HOME is home, but for
# the WSL shell home is the unix home and OS_HOME gets set to the machines user
# profile (/mnt/c/Users/<name>).  This allows cd on its own to take you to the unix home but cdh
# to take you to the "windows" home.
export OS_HOME=$HOME

# Some quick navigations
alias cdp="cd $MY_PROFILE/projects"
alias cdpp="cd $MY_PROFILE/projects/personal"
alias cdd="cd $MY_PROFILE/downloads"
alias cdi="cd $MY_PROFILE/downloads/installs"

alias cdh="cd $OS_HOME"

