#!/usr/bin/env bash

if command_exists npm; then
  alias npr='npm run'
fi

NPM_CONFIG_USERCONFIG="$(xdg-base-dir CONFIG)/npm/npmrc"
export NPM_CONFIG_USERCONFIG
