#!/usr/bin/env bash

function yt {
    url=$(xclip -o)
    echo "Downloading $url"
    youtube-dl "$url"
}

