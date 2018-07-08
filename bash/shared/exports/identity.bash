#!/usr/bin/env bash

export NAME="Brennan Fee"

export HOME_EMAIL="brennan@todaytechsoft.com"
export WORK_EMAIL="bfee@uship.com"

export EMAIL="$HOME_EMAIL"

rc_tags=$(grep -i '^TAGS=' "$HOME/.rcrc" | sed -e 's/^TAGS=//' | tr '[:upper:]' '[:lower:]')
if [[ $rc_tags == *"work"* ]]; then
  export EMAIL="$WORK_EMAIL"
fi

unset rc_tags
