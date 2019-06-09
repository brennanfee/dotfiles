#!/usr/bin/env bash

# Set languages
export LANG="en_US.UTF-8"
export LANGUAGE="en_US:en"
export LC_ALL="en_US.UTF-8"

# Timezone
export TZ="US/Central"

# Set terminal
export TERM=xterm-256color

# Turn on colors
export CLICOLOR=1
export LS_OPTIONS="-hv --color=auto --group-directories-first --time-style=long-iso"

# Editors and pagers
export VIM_VER
VIM_VER="$($(which vim) --version | grep "Vi IMproved" | awk '{print $5}' | sed -e 's/\.//g')"
export EDITOR='vim'
export GIT_EDITOR='vim'
export SVN_EDITOR='vim'
export LESSEDIT='vim'

export VISUAL='vim'
# if command_exists code; then
#   export VISUAL='code'
# elif command_exists atom; then
#   export VISUAL='atom'
# elif command_exists gvim; then
#   export VISUAL='gvim'
# else
#   export VISUAL='vim'
# fi

# Pager
export PAGER="less"
export MANPAGER="less"

export LESS="--LINE-NUMBERS --quit-if-one-screen --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --chop-long-lines --tabs=4 --window=-4 --quiet"
export LESSHISTFILE="$HOME/.config/lesshst"

if type source-highlight >/dev/null 2>&1; then
  export LESSOPEN="| ~/.dotfiles/bin/src-hilite-lesspipe.sh %s"
elif type lesspipe >/dev/null 2>&1; then
  export LESSOPEN="| lesspipe %s"
fi

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# shellcheck disable=SC2154
export SUDO_PROMPT="${i_fa_lock} password for %u@%h: "

# History
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignorespace
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ls -la:sl:ll:la:lls:lla:pwd:cd:cdp:cdpp:cdd:cdi:cdt:cdtp:cdm:cdmp:cdv:cdb:cdc:cdx:cdh:cdr:cdw:* --help *'
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTFILE=~/.cache/bash_history

# Suffixes to ignore for filename completion
export FIGNORE=".git:.DS_Store"
