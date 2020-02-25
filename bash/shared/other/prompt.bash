#!/usr/bin/env bash

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

if [[ $GIT_PS1_USEGIT -eq 1 ]]; then
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM="verbose git"
  GIT_PS1_SHOWCOLORHINTS=1
fi

function custom_prompt() {
  local last_exit=$?
  if [[ $last_exit -eq 0 ]]; then
    # shellcheck disable=SC2154
    local exit_status="${color_green}${i_fa_check}"
  else
    # shellcheck disable=SC2154
    local exit_status="${color_red}${i_fa_close} (\$?)"
  fi

  local ssh_text=""
  if [[ -n $SSH_CLIENT ]]; then
    # shellcheck disable=SC2154
    local ssh_text="${color_cyan}(SSH) "
  fi

  # shellcheck disable=SC2154
  local curShell="${color_blue}("
  if [[ $IS_WSL == "true" ]]; then
    curShell+="WSL "
  fi
  if [[ "$0" == "-bash" ]] || [[ "$0" == "/bin/bash" ]]; then
    curShell+="bash)"
  else
    curShell+="$0)"
  fi

  if [[ $GIT_PS1_USEGIT -eq 1 ]]; then
    local git_part
    # shellcheck disable=SC2154
    git_part=$(__git_ps1 "${color_yellow}[%s] ")
    export PS1
    # shellcheck disable=SC2154
    PS1="${color_normal}\n${ssh_text}${color_green}\u@\h ${color_purple}\w ${git_part}${curShell} ${exit_status} ${color_normal}\n\$ "
  else
    export PS1="${color_normal}\n${ssh_text}${color_green}\u@\h ${color_purple}\w ${curShell} ${exit_status} ${color_normal}\n\$ "
  fi
}

PROMPT_COMMAND=custom_prompt
