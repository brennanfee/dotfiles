#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

fdupes -r $@ | {
    while IFS= read -r file; do
        [[ $file ]] && du -h "$file"
    done
} | sort -n

