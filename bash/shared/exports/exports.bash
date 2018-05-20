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
export LS_OPTIONS="-h --color=auto --group-directories-first --time-style=long-iso"

# User Agent
# List of user agents: http://www.useragentstring.com/pages/useragentstring.php
export USER_AGENT="Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko)"

# Editors and pagers
export VIM_VER="$($(which vim) --version | grep "Vi IMproved" | awk '{print $5}' | sed -e 's/\.//g')"
export EDITOR='vim'
export GIT_EDITOR='vim'
export SVN_EDITOR='vim'
export LESSEDIT='vim'

if [[ -x /usr/bin/code ]]; then
    export VISUAL='/usr/bin/code'
else
    export VISUAL='gvim'
fi

if command_exists most; then
    export PAGER="most"
    export MANPAGER="most -s"
fi
export GIT_PAGER="less"

export SUDO_PROMPT="${i_fa_lock} password for %u@%h: "

# History
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignorespace
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:ls -la:sl:ll:la:lls:lla:pwd:cd:cd*:* --help *'
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
export HISTFILESIZE=5000
export HISTSIZE=5000
export HISTFILE=~/.cache/bash_history

# Suffixes to ignore for filename completion
export FIGNORE=".git:.DS_Store"
