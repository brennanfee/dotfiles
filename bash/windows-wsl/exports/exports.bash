#!/usr/bin/env bash

# Override the browser
export BROWSER=/usr/local/bin/chrome.exe

# Move temp directory (lots of windows tools can't read the Linux tmp path)
if [[ -d '/mnt/c/Users/brennan/AppData/Local/Temp' ]]; then
    export TMPDIR='/mnt/c/Users/brennan/AppData/Local/Temp'
elif [[ -d '/mnt/c/Users/Brennan/AppData/Local/Temp' ]]; then
    export TMPDIR='/mnt/c/Users/Brennan/AppData/Local/Temp'
elif [[ -d '/mnt/c/Users/bfee/AppData/Local/Temp' ]]; then
    export TMPDIR='/mnt/c/Users/bfee/AppData/Local/Temp'
fi

# Force the Display output
export DISPLAY=:0

# Notate we support true colors
export COLORTERM=truecolor

