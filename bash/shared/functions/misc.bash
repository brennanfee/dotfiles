#!/usr/bin/env bash

function reload_profile() {
  # shellcheck source=/dev/null
  source "$HOME/.bash_profile"
}

function lsgrep() {
  # shellcheck disable=SC2010
  ls -A | grep -i "$@"
}

function llgrep() {
  # shellcheck disable=SC2010
  ls -hlA --time-style=long-iso | grep -i "$@"
}

function lsrg() {
  # shellcheck disable=SC2012
  ls -A | rg -S "$@"
}

function llrg() {
  # shellcheck disable=SC2012
  ls -hlA --time-style=long-iso | rg -S "$@"
}

function psgrep() {
  # shellcheck disable=SC2009,SC2001
  ps aux | grep -i "$(echo "$@" | sed "s/^\(.\)/[\1]/g")"
}

function psrg() {
  # shellcheck disable=SC2001
  ps aux | rg -S "$(echo "$@" | sed "s/^\(.\)/[\1]/g")"
}

function myip() {
  curl ifconfig.co/ip
}

function usage() {
  if [ -n "$1" ]; then
    du -h --max-depth=1 "$1" | sort -hr
  else
    du -h --max-depth=1 | sort -hr
  fi
}

function weather() {
  curl -sL "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${1:-<YOURZIPORLOCATION>}" | perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"'
}
