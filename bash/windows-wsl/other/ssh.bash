#!/usr/bin/env bash

# Set up ssh-agent
SSH_ENV="${HOME}/.ssh/environment"

function start_agent() {
  echo "Initializing new SSH agent..."
  [[ -f ${SSH_ENV} ]] && rm "${SSH_ENV}" >/dev/null
  touch "${SSH_ENV}"
  chmod 600 "${SSH_ENV}"
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' || true >>"${SSH_ENV}"
  # shellcheck source=/dev/null
  source "${SSH_ENV}" >/dev/null
}

# Source SSH settings, if applicable
if [[ -f "${SSH_ENV}" ]]; then
  # shellcheck source=/dev/null
  source "${SSH_ENV}" >/dev/null
  agent_pid=${SSH_AGENT_PID:-}
  if [[ -z ${agent_pid} ]]; then
    kill -0 "${agent_pid}" 2>/dev/null || {
      start_agent
    }
  fi
else
  start_agent
fi

unset agent_pid
