#!/usr/bin/env bash

function reload_profile() {
  # shellcheck source=/dev/null
  source "$HOME/.bash_profile"
}

alias lsgrep="ls | grep -i \"$@\""

# function lsgrep() {
#   # shellcheck disable=SC2010
#   ls | grep -i "$@"
# }

function lagrep() {
  # shellcheck disable=SC2010
  ls -A | grep -i "$@"
}

function lsrg() {
  # shellcheck disable=SC2012
  ls | rg "$@"
}

function larg() {
  # shellcheck disable=SC2012
  ls -A | rg "$@"
}

function psgrep() {
  # shellcheck disable=SC2009,SC2001
  ps aux | grep -i "$(echo "$@" | sed "s/^\(.\)/[\1]/g")"
}

function psrg() {
  # shellcheck disable=SC2001
  ps aux | rg "$(echo "$@" | sed "s/^\(.\)/[\1]/g")"
}

function myip() {
  local res
  res=$(curl -sL checkip.dyndns.org | grep -Eo '[0-9\.]+')
  echo -e "Your public IP is: $res"
}

function usage() {
  if [ -n "$1" ]; then
    du -h --max-depth=1 "$1"
  else
    du -h --max-depth=1
  fi
}

function weather() {
  curl -sL "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${1:-<YOURZIPORLOCATION>}" | perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"'
}
