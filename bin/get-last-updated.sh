#!/usr/bin/env sh

get_last_updated () {
  local update_log_file="${HOME}/.cache/updates.log"

  if [ -f "${update_log_file}" ]
  then
    tail -n 1 "${update_log_file}"
  else
    echo "unknown"
  fi
}

get_last_updated
