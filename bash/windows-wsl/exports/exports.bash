#!/usr/bin/env bash

# Override the browser
export BROWSER=/usr/local/bin/chrome.exe

# Setup a visual editor
if [[ -x "/mnt/c/Program Files/Microsoft VS Code/bin/code" ]]; then
    export VISUAL="/mnt/c/Program Files/Microsoft VS Code/bin/code"
fi

# Force the Display output
export DISPLAY=:0

# Notate we support true colors
export COLORTERM=truecolor
