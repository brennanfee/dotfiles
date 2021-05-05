#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# Finds all private key files (that are protected, based on mode bits)
# and adds each to ssh agent
for filename in ~/.ssh/*; do
  perms=$(stat $filename|sed -n '/^Access: (/{s/Access: (\([0-9]\+\).*$/\1/;p}')

  filetype=$(file $filename)

  if [[ "$perms" == "0600" && "$filetype" == *"private key" ]]; then
    ssh-add $filename
  fi
done

