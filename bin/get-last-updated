#!/usr/bin/env sh

get_last_updated() {
  update_log_file="${XDG_CACHE_HOME:-$HOME/.cache}/updates.log"

  if [ -f "${update_log_file}" ]; then
    tail -n 1 "${update_log_file}"
  else
    echo "unknown"
  fi
}

get_last_updated
