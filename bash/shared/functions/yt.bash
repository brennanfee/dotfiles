#!/usr/bin/env bash

function yt() {
  if [[ $IS_WSL == "1" ]]; then
    url=$(paste.exe)
    echo "Downloading $url"
    youtube-dl.exe "$url"
  else
    url=$(xsel -o --clipboard)
    echo "Downloading $url"
    if command_exists aria2c; then
      youtube-dl --external-downloader=aria2c "$url"
    else
      youtube-dl "$url"
    fi
  fi
}
