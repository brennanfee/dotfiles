#!/usr/bin/env bash

export MISE_SHELL=bash
export __MISE_ORIG_PATH="$PATH"

mise() {
  local command
  command="${1:-}"
  if [ "$#" = 0 ]; then
    command mise
    return
  fi
  shift

  case "$command" in
    deactivate | shell | sh)
      # if argv doesn't contains -h,--help
      if [[ ! " $* " =~ " --help " ]] && [[ ! " $* " =~ " -h " ]]; then
        eval "$(command mise "$command" "$@")"
        return $?
      fi
      ;;
  esac
  command mise "$command" "$@"
}

_mise_hook() {
  log "calling _mise_hook"
  local previous_exit_status=$?
  eval "$(mise hook-env -s bash)"
  return $previous_exit_status
}
if [[ -n "${bash_preexec_imported:-}" ]]; then
  if [[ "${precmd_functions[*]:-}" != *"_mise_hook"* ]]; then
    precmd_functions+=(_mise_hook)
  fi
else
  if [[ "$(declare -p PROMPT_COMMAND)" =~ "declare -a" ]]; then
    if [[ ${PROMPT_COMMAND[*]:-} != *"_mise_hook"* ]]; then
      PROMPT_COMMAND+=(_mise_hook)
    fi
  else
    if [[ ";${PROMPT_COMMAND:-};" != *";_mise_hook;"* ]]; then
      # shellcheck disable=SC2128,SC2178
      PROMPT_COMMAND="_mise_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
    fi
  fi
fi
# shellcheck shell=bash
export -a chpwd_functions
function __zsh_like_cd() {
  \typeset __zsh_like_cd_hook
  if
    builtin "$@"
  then
    for __zsh_like_cd_hook in chpwd "${chpwd_functions[@]}"; do
      if \typeset -f "$__zsh_like_cd_hook" > /dev/null 2>&1; then
        "$__zsh_like_cd_hook" || break # finish on first failed hook
      fi
    done
    true
  else
    return $?
  fi
}

# shellcheck shell=bash
[[ -n ${ZSH_VERSION:-} ]] \
  || {
    function cd() { __zsh_like_cd cd "$@"; }
    function popd() { __zsh_like_cd popd "$@"; }
    function pushd() { __zsh_like_cd pushd "$@"; }
  }

chpwd_functions+=(_mise_hook)
_mise_hook
if [ -z "${_mise_cmd_not_found:-}" ]; then
  _mise_cmd_not_found=1
  if [ -n "$(declare -f command_not_found_handle)" ]; then
    _mise_cmd_not_found_handle=$(declare -f command_not_found_handle)
    eval "${_mise_cmd_not_found_handle/command_not_found_handle/_command_not_found_handle}"
  fi

  command_not_found_handle() {
    if [[ $1 != "mise" && $1 != "mise-"* ]] && mise hook-not-found -s bash -- "$1"; then
      _mise_hook
      "$@"
    elif [ -n "$(declare -f _command_not_found_handle)" ]; then
      _command_not_found_handle "$@"
    else
      echo "bash: command not found: $1" >&2
      return 127
    fi
  }
fi
