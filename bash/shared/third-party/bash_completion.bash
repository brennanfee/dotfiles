#!/usr/bin/env bash

# Bash Completion
completions_loaded=0
if [[ -f "/usr/local/etc/bash_completion" ]]; then
  # shellcheck disable=SC1091
  source "/usr/local/etc/bash_completion"
  completions_loaded=1
fi

if [[ $completions_loaded == 0 && -f "/etc/bash_completion" ]]; then
  source "/etc/bash_completion"
fi

unset completions_loaded
