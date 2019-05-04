#!/usr/bin/env bash

function yt-helper() {
  local url
  if [[ $IS_WSL == "1" ]]; then
    url=$(paste.exe)
    echo "Downloading $url"
    youtube-dl.exe -o "$1" "$url"
  else
    url=$(xsel -o --clipboard)
    echo "Downloading $url"
    if command_exists aria2c; then
      youtube-dl --external-downloader=aria2c -o "$1" "$url"
    else
      youtube-dl -o "$1" "$url"
    fi
  fi
}

function yt() {
  local output
  output="$(xdg-user-dir VIDEOS)/%(title)s.%(ext)s"
  yt-helper "$output"
}

function pt() {
  local output
  output="$(xdg-user-dir PICTURES)/!other/%(title)s.%(ext)s"
  yt-helper "$output"
}

