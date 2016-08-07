#!/usr/bin/env bash

# Set languages
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set terminal
export TERM=xterm-256color

# Turn on colors
export CLICOLOR=1
export LS_OPTIONS="-h --color=auto"

# User Agent
# List of user agents: http://www.useragentstring.com/pages/useragentstring.php
export USER_AGENT="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)"

# Editors and pagers
export VIM_VER="$($(which vim) --version | grep "Vi IMproved" | awk '{print $5}' | sed -e 's/\.//g')"
export VISUAL='vim'
export EDITOR='vim'
export GIT_EDITOR='vim'
export SVN_EDITOR='vim'
export LESSEDIT='vim'
export PAGER="most"
export MANPAGER="most -s"

# History
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignorespace
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:pwd:cd:cd -:* --help *'
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
export HISTFILESIZE=5000
export HISTSIZE=5000

# Suffixes to ignore for filename completion
export FIGNORE=".git:.DS_Store"

# Python
#export WORKON_HOME="$HOME/.virtualenvs"
#export PIP_VIRTUALENV_BASE="$WORKON_HOME"
#export VIRTUALENV_PYTHON="/usr/bin/python2"
#export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python2"
