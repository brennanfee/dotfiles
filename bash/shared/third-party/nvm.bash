#!/usr/bin/env bash

if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use # This loads nvm
fi

if [[ -z $TMUX ]]; then
    if command_exists nvm; then
        nvm use --lts &> /dev/null
    fi
fi

