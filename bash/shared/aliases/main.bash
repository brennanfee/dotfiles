#!/usr/bin/env bash

# Turn on colors
alias ls='ls $LS_OPTIONS'
alias dir='ls -A --format=vertical'
alias vdir='ls -A --format=long'
alias tree="tree -C"

alias grep="grep --color"
alias pgrep="grep --color"
alias egrep="grep --color"

# Make sudo preserve home
alias sudo="sudo -H"

# Most is less
if command_exists most; then
    alias less="most"
    alias more="most"
fi

# Alternates/extensions of ls
alias la="ls -A"
alias ll="ls -oh"
alias lla="ls -ohA"
alias lls="ls -ohA"
alias ldir='ls -ohA | grep --color=never "^d"'

# Directory & file
alias md='mkdir -p'
alias mkdir="mkdir -p"

# Top, ps, and other process tools
alias psgrep='ps aux | grep $(echo $1 | sed "s/^\(.\)/[\1]/g")'
alias psag='ps aux | ag $(echo $1 | sed "s/^\(.\)/[\1]/g")'

# Default to human readable figures
alias vi="vim"
alias df='df -h'
alias du='du -h'

# DOS like clear
alias cls="clear"

# Editor mappings
alias e="${EDITOR}"
alias edit="${EDITOR}"
alias v="vim -R"
alias view="vim -R"

# Vim typos
alias :q="exit"
alias :wq="exit"
alias :x="exit"

# History
alias histg='history | grep'
alias hist='history | ag'

# Utility commands
alias mkdatedir='mkdir $(date "+%Y-%m-%d")'
alias mkdatefile='touch $(date "+%Y-%m-%d").txt'

# CD typos
alias cd.='cd ..'
alias cd..='cd ..'
alias cdu='cd ..'

# RipGrep should always use "smart-case"
if command_exists rg; then
    alias rg='rg -S'
fi

# Markdown & CommonMark
# May not need this anymore, should use node
#alias markdown="Markdown.pl"

# vless
alias vless="/usr/share/vim/vim$VIM_VER/macros/less.sh"

# Setting up command-line web tools with a user agent
if [[ ! $USER_AGENT == "" ]]; then
    alias wget='wget --user-agent="$USER_AGENT"'
    alias curl='curl -A "$USER_AGENT"'
fi

if command_exists thefuck; then
    eval $(thefuck --alias)
fi

