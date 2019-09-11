#!/usr/bin/env bash

function yt-helper() {
  local url
  if [[ $IS_WSL == "1" ]]; then
    url=$(powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command Get-Clipboard)
    echo "Downloading $url"
    if command_exists aria2c.exe; then
      youtube-dl.exe --external-downloader=aria2c.exe -o "$1" "$url" "${@:2}"
    else
      youtube-dl.exe -o "$1" "$url" "${@:2}"
    fi
  else
    url=$(xsel -o --clipboard)
    echo "Downloading $url"
    if command_exists aria2c; then
      youtube-dl --external-downloader=aria2c -o "$1" "$url" "${@:2}"
    else
      youtube-dl -o "$1" "$url" "${@:2}"
    fi
  fi
}

function yt() {
  local output
  output="$(xdg-user-dir VIDEOS)/%(title)s.%(ext)s"
  yt-helper "$output" "$@"
}

function pt() {
  local output
  output="$(xdg-user-dir PICTURES)/!other/%(title)s.%(ext)s"
  yt-helper "$output" "$@"
}

# To extract an MP3 from a video, requires ffmpeg to be installed
function ytm() {
  local output
  output="$(xdg-user-dir VIDEOS)/%(title)s-youtube.%(ext)s"

  local url
  if [[ $IS_WSL == "1" ]]; then
    url=$(powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command Get-Clipboard)
    echo "Downloading $url"
    if command_exists aria2c.exe; then
      youtube-dl.exe --extract-audio --audio-format mp3 --external-downloader=aria2c.exe -o "$output" "$url" "${@:2}"
    else
      youtube-dl.exe --extract-audio --audio-format mp3 -o "$output" "$url" "${@:2}"
    fi
  else
    url=$(xsel -o --clipboard)
    echo "Downloading $url"
    if command_exists aria2c; then
      youtube-dl --extract-audio --audio-format mp3 --external-downloader=aria2c -o "$output" "$url" "${@:2}"
    else
      youtube-dl --extract-audio --audio-format mp3 -o "$output" "$url" "${@:2}"
    fi
  fi
}
