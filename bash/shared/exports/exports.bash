#!/usr/bin/env bash

# Set temps, for consistency
if [[ -d /tmp ]]; then
  export TMP="/tmp"
  export TEMP="/tmp"
  export TMPDIR="/tmp"
fi

# Set languages
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_ALL="en_US.UTF-8"

# Timezone
export TZ="US/Central"

# Set terminal
export TERM=screen-256color

# Turn on colors
export CLICOLOR=1
export LS_OPTIONS="-hv --color=auto --group-directories-first --time-style=long-iso"

# Editors

# shellcheck disable=SC2154
export SUDO_PROMPT="${i_fa_lock} password for %u@%h: "

# Suffixes to ignore for filename completion
export FIGNORE=".git:.DS_Store"

# X11
ERRFILE="$(xdg-base-dir CACHE)/X11/xsession-errors"
# Note: Some display managers will not support this (LightDM or SLiM)
XAUTHORITY="(xdg-base-dir RUNTIME)/Xauthority"

export ERRFILE
export XAUTHORITY

# Input
INPUTRC="$(xdg-base-dir CONFIG)/readline/inputrc"
export INPUTRC
