#!/usr/bin/env bash

function mkbk {
  if [ ! -n "$1" ]; then
    echo -e "${color_red}Enter a file name${color_reset}"
  else
    local filename=$1
    local filetime=$(date +%Y%m%d_%H%M%S)
    cp ${filename} ${filename}_${filetime}
  fi
}

alias mkback='mkbk'

function mkorig {
    if [ ! -n "$1" ]; then
        echo -e "${color_red}Enter a file name${color_reset}"
    else
        cp ${1} ${1}.orig
    fi
}

function mkcd {
  if [ ! -n "$1" ]; then
    echo -e "${color_red}Enter a directory name${color_reset}"
  else
    mkdir -p $1 && cd $1
  fi
}
