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

shopt -s inherit_errexit

export PROMPT_DIRTRIM=4

GIT_PS1_USEGIT=0

if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
  source '/usr/lib/git-core/git-sh-prompt'
  GIT_PS1_USEGIT=1
fi

if [[ -e /usr/lib/git/git-core/git-sh-prompt ]]; then
  source '/usr/lib/git/git-core/git-sh-prompt'
  GIT_PS1_USEGIT=1
fi

if [[ -e /usr/share/git/git-prompt.sh ]]; then
  source '/usr/share/git/git-prompt.sh'
  GIT_PS1_USEGIT=1
fi

if [[ ${GIT_PS1_USEGIT} -eq 1 ]]; then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM="verbose git"
  GIT_PS1_SHOWCOLORHINTS=1
fi

function custom_prompt() {
  local last_exit=$?
  if [[ ${last_exit} -eq 0 ]]; then
    # shellcheck disable=SC2154
    local exit_status="${text_green}${i_fa_check}"
  else
    # shellcheck disable=SC2154
    local exit_status="${text_red}${i_fa_close} (\$?)"
  fi

  local ssh_text=""
  if [[ -n ${SSH_CLIENT} ]]; then
    # shellcheck disable=SC2154
    local ssh_text="${text_cyan}(SSH) "
  fi

  # shellcheck disable=SC2154
  local curShell="${text_blue}("
  if is_wsl; then
    curShell+="WSL "
  fi
  if [[ "$0" == "-bash" ]] || [[ "$0" == "/bin/bash" ]]; then
    curShell+="bash)"
  else
    curShell+="$0)"
  fi
  if [[ "${VIRTUAL_ENV}" != "" ]]; then
    curShell+="${text_red} VENV($(basename "${VIRTUAL_ENV}"))"
  fi

  if [[ ${GIT_PS1_USEGIT} -eq 1 ]]; then
    local git_part
    # shellcheck disable=SC2154
    git_part=$(__git_ps1 "${text_orange}[%s] ")
    export PS1
    # shellcheck disable=SC2154
    PS1="${text_normal}\n${ssh_text}${text_green}\u@\h ${text_magenta}\w ${git_part}${curShell} ${exit_status} ${text_normal}\n\$ "
  else
    export PS1="${text_normal}\n${ssh_text}${text_green}\u@\h ${text_magenta}\w ${curShell} ${exit_status} ${text_normal}\n\$ "
  fi
}

PROMPT_COMMAND=custom_prompt

if command_exists mise; then
  if [[ ";${PROMPT_COMMAND:-};" != *";_mise_hook;"* ]]; then
    PROMPT_COMMAND="_mise_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
  fi
fi

#unset GIT_PS1_USEGIT
