#!/usr/bin/env bash

function yt-helper() {
  local url
  if [[ $IS_WSL == "1" ]]; then
    url=$(powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command Get-Clipboard)
  else
    url=$(xsel -o --clipboard)
  fi

  local highFormat="bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]/bestvideo[ext=webm][height<=?1080]+bestaudio[ext=webm]/best[height<=?1080]/best"
  local lowFormat="bestvideo[ext=mp4][height<=?720]+bestaudio[ext=m4a]/bestvideo[ext=webm][height<=?720]+bestaudio[ext=webm]/best[height<=?720]/best"
  local format="$highFormat"

  if [[ "$1" == "low" ]]; then
    format="$lowFormat"
  fi

  prog="youtube-dl"
  if [ command -v "yt-dlp" &>/dev/null -eq 1 ]; then
    prog="yt-dlp"
  fi

  echo "Downloading $url"
  $prog -i -f "$format" -o "$2" "$url" "${@:3}"
}

function yt() {
  local output
  output="$(xdg-user-dir VIDEOS)/%(title)s-%(id)s.%(ext)s"
  yt-helper "high" "$output" "$@"
}

function pt() {
  local output
  output="$(xdg-user-dir PICTURES)/!other/%(title)s-%(id)s.%(ext)s"
  yt-helper "low" "$output" "$@"
}

# To extract an MP3 from a video, requires ffmpeg to be installed
function ytm() {
  local output
  output="$(xdg-user-dir VIDEOS)/%(title)s-youtube.%(ext)s"

  local url
  if [[ $IS_WSL == "1" ]]; then
    url=$(powershell.exe -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command Get-Clipboard)
  else
    url=$(xsel -o --clipboard)
  fi

  prog="youtube-dl"
  if [ command -v "yt-dlp" &>/dev/null -eq 1 ]; then
    prog="yt-dlp"
  fi

  echo "Downloading $url"
  $prog --extract-audio --audio-format mp3 -i -o "$output" "$url" "${@:2}"
}
