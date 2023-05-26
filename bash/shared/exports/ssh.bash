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
# END Bash scrict mode

if [[ ${IS_WSL} == "1" ]]; then
  # WSL SSH is being handled completely differently from Linux
  exit
fi

# Configure ask pass
if type ksshaskpass > /dev/null 2>&1; then
  SSH_ASKPASS=$(command -v ksshaskpass)
  export SSH_ASKPASS
  export SSH_ASKPASS_REQUIRE=prefer
elif type x11-ssh-askpass > /dev/null 2>&1; then
  SSH_ASKPASS=$(command -v x11-ssh-askpass)
  export SSH_ASKPASS
  export SSH_ASKPASS_REQUIRE=prefer
elif type ssh-askpass > /dev/null 2>&1; then
  SSH_ASKPASS=$(command -v ssh-askpass)
  export SSH_ASKPASS
  export SSH_ASKPASS_REQUIRE=prefer
fi

# Set up ssh-agent
SSH_ENV="${HOME}/.ssh/environment"

function start_agent() {
  #  echo "Initializing new SSH agent..."
  [[ -f ${SSH_ENV} ]] && rm "${SSH_ENV}" > /dev/null
  touch "${SSH_ENV}"
  chmod 600 "${SSH_ENV}"
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
  # shellcheck source=/dev/null
  source "${SSH_ENV}" > /dev/null

  if command_exists ssh-add-keys; then
    ssh-add-keys
  fi
}

# Source SSH settings, if applicable
if [[ -f "${SSH_ENV}" ]]; then
  # shellcheck source=/dev/null
  source "${SSH_ENV}" > /dev/null
  kill -0 "${SSH_AGENT_PID}" 2> /dev/null || {
    start_agent
  }
else
  start_agent
fi
