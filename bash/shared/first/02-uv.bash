#!/usr/bin/env bash

# Bash strict mode
# shellcheck disable=SC2154
([[ -n ${ZSH_EVAL_CONTEXT} && ${ZSH_EVAL_CONTEXT} =~ :file$ ]] \
  || [[ -n ${BASH_VERSION} ]] && (return 0 2> /dev/null)) && SOURCED=true || SOURCED=false
if ! ${SOURCED}; then
  set -o errexit  # same as set -e
  set -o nounset  # same as set -u
  set -o errtrace # same as set -E
  set -o pipefail
  set -o posix
  #set -o xtrace # same as set -x, turn on for debugging

  shopt -s extdebug
  IFS=$(printf '\n\t')
fi
# END Bash strict mode

export INSTALLER_NO_MODIFY_PATH=1

if command -v uv &> /dev/null; then
  eval "$(uv generate-shell-completion bash)"

  export UV_NATIVE_TLS="true"
  export UV_PYTHON_PREFERENCE="only-managed"

  alias uvr="uv run"
fi

if command -v uvx &> /dev/null; then
  eval "$(uvx --generate-shell-completion bash)"
fi
