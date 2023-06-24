#!/usr/bin/env bash

# Bash strict mode
([[ -n ${ZSH_EVAL_CONTEXT:-} && ${ZSH_EVAL_CONTEXT:-} =~ :file$ ]] \
  || [[ -n ${BASH_VERSION:-} ]] && (return 0 2> /dev/null)) && SOURCED=true || SOURCED=false
if ! ${SOURCED}; then
  set -o errexit  # same as set -e
  set -o nounset  # same as set -u
  set -o errtrace # same as set -E
  set -o pipefail
  set -o posix
  #set -o xtrace # same as set -x, turn on for debugging

  shopt -s inherit_errexit
  shopt -s extdebug
  IFS=$(printf '\n\t')
fi

SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# END Bash strict mode

# Source script-tools.bash
if [[ -f "${SCRIPT_DIR}/script-tools.bash" ]]; then
  # shellcheck source=/home/brennan/.dotfiles/bash/script-tools.bash
  source "${SCRIPT_DIR}/script-tools.bash"
fi

#### Profile Environment Variables - Critical locations

# For Windows WSL I use the WSLENV environment variable to pass in the values
# some path values along with a custom value WIN_USER.  WIN_USER should be set
# to the %USERNAME% value in Windows.  The WIN_USER variable is used in
# situations where the Unix (WSL) and Windows usernames might differ (which
# will be common).  PROFILEPATH is a custom value that gets set with my standard
# PowerShell profile scripts and points to my main profile location.
# Both USERPROFILE and SystemRoot are standard paths available in Windows by
# default.  The WSLENV should be set to:
# USERPROFILE/up:PROFILEPATH/up:SystemRoot/up:WIN_USER
PROFILEPATH=$(xdg-user-dir PROFILE)
PROFILEPATH="${PROFILEPATH:-${HOME}/profile}"
if [[ ! -d "${PROFILEPATH}" ]]; then
  PROFILEPATH="${HOME}"
fi

export PROFILEPATH

# This is only here for Windows and WSL.  For all non-Windows machines $HOME is "home", but
# for my WSL shells I keep track of two homes.  The "Linux" home stays as "home" (cd -) but
# I also track the "windows" home (usually C:\Users\<username>).  This I map to cdh.  On
# linux cdh is the same as just cd, but on windows they will be two different paths with
# two different environment variables $HOME and $WIN_HOME pointing to each, respectively.
WIN_HOME="${USERPROFILE:-${HOME}}"
if [[ ! -d "${WIN_HOME}" ]]; then
  WIN_HOME="${HOME}"
fi

export WIN_HOME

# Dotfiles locations
DOTFILES=$(xdg-user-dir DOTFILES)
DOTFILES="${DOTFILES:-${HOME}/.dotfiles}"

DOTFILES_PRIVATE=$(xdg-user-dir DOTFILESPRIVATE)
DOTFILES_PRIVATE="${DOTFILES_PRIVATE:-${HOME}/.dotfiles-private}"

export DOTFILES
export DOTFILES_PRIVATE

## OS Environment Variables - Indicate what type of machine we are running on.

uname=$(uname -s | tr '[:upper:]' '[:lower:]' || true)
if [[ ${uname} == "darwin" ]]; then
  OS_PRIMARY="macos"
  OS_SECONDARY="macos"
elif [[ ${uname} == "linux" ]]; then
  OS_PRIMARY="linux"
  OS_SECONDARY=$(grep -i '^ID=' < /etc/os-release | sed -e 's/^ID=//;s/"//g' | tr '[:upper:]' '[:lower:]' || true)
  if [[ "${OS_SECONDARY}" == "" ]]; then
    OS_SECONDARY="unknown"
  fi
elif [[ ${uname} == "freebsd" ]]; then
  OS_PRIMARY="bsd"
  OS_SECONDARY="freebsd"
elif [[ ${uname} == "openbsd" ]]; then
  OS_PRIMARY="bsd"
  OS_SECONDARY="openbsd"
else
  OS_PRIMARY="unknown"
  OS_SECONDARY="unknown"
fi

unset uname

export OS_PRIMARY
export OS_SECONDRAY

# Utility methods to determine system type

function is_mac() {
  if [[ ${OS_PRIMARY:-linux} == "macos" ]]; then
    return 0
  else
    return 1
  fi
}

function is_linux() {
  if [[ ${OS_PRIMARY:-linux} == "linux" ]]; then
    return 0
  else
    return 1
  fi
}

function is_windows() {
  if is_wsl; then
    return 0
  else
    return 1
  fi
}
