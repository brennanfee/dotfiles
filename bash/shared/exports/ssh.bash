#!/usr/bin/env bash

# Configure ask pass
if type ksshaskpass >/dev/null 2>&1; then
  export SSH_ASKPASS=$(which ksshaskpass)
  export SSH_ASKPASS_REQUIRE=prefer
elif type x11-ssh-askpass >/dev/null 2>&1; then
  export SSH_ASKPASS=$(which x11-ssh-askpass)
  export SSH_ASKPASS_REQUIRE=prefer
elif type ssh-askpass >/dev/null 2>&1; then
  export SSH_ASKPASS=$(which ssh-askpass)
  export SSH_ASKPASS_REQUIRE=prefer
fi

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent() {
#  echo "Initializing new SSH agent..."
  [[ -f $SSH_ENV ]] && rm "$SSH_ENV" >/dev/null
  touch "$SSH_ENV"
  chmod 600 "${SSH_ENV}"
  /usr/bin/ssh-agent | sed 's/^echo/#echo/' >>"${SSH_ENV}"
  # shellcheck source=/dev/null
  source "${SSH_ENV}" >/dev/null
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
  # shellcheck source=/dev/null
  source "${SSH_ENV}" >/dev/null
  kill -0 "$SSH_AGENT_PID" 2>/dev/null || {
    start_agent
  }
else
  start_agent
fi
