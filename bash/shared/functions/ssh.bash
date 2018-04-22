#!/usr/bin/env bash

function ssh-list() {
    awk '$1 ~ /Host$/ { print $2 }' ~/.ssh/config
}
