#!/usr/bin/env bash

if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh" # This loads nvm
fi

if command_exists nvm; then
    nvm use --lts &> /dev/null
fi

