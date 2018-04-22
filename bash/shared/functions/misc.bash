#!/usr/bin/env bash

function reload_profile() {
    source "$HOME/.bash_profile"
}

function lsgrep() {
    ls | grep -i "$*"
}

function lagrep() {
    ls -A | grep -i "$*"
}

function lsag() {
    ls | ag -i "$*"
}

function laag() {
    ls -A | ag -i "$*"
}

function myip() {
    local res=$(curl -sL checkip.dyndns.org | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: $res"
}

function usage() {
    if [ -n $1 ]; then
        du -h --max-depth=1 $1
    else
        du -h --max-depth=1
    fi
}

function weather() {
    curl -sL "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<YOURZIPORLOCATION>}" | perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&print $1,"\n"'
}
