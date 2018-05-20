#!/usr/bin/env bash

function yt() {
    if [[ $IS_WSL ]]; then
        url=$(win32yank.exe -o)
        echo "Downloading $url"
        youtube-dl.exe "$url"
    else
        url=$(xclip -o)
        echo "Downloading $url"
        youtube-dl "$url"
    fi
}
