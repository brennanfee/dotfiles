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
# END Bash strict mode

#### Profile Environment Variables - Critical locations

# For Windows WSL I use the WSLENV environment variable to pass in the values
# some path values along with a custom value WIN_USER.  WIN_USER should be set
# to the %USERNAME% value in Windows.  The WIN_USER variable is used in
# situations where the Unix (WSL) and Windows usernames might differ (which
# will be common).  PROFILEPATH is a custom value that gets set with my standard
# PowerShell profile scripts and points to my main profile location.
# Both USERPROFILE and SystemRoot are standard paths available in Windows by
# default.  The WSLENV environment variable should be set to:
# USERPROFILE/up:PROFILEPATH/up:SystemRoot/up:WIN_USER
PROFILEPATH="${PROFILEPATH:-$(xdg-user-dir PROFILE)}"
PROFILEPATH="${PROFILEPATH:-$HOME/profile}"
if [[ ! -d "${PROFILEPATH}" ]]; then
  PROFILEPATH="${HOME}/profile"
  if [[ ! -d "${PROFILEPATH}" ]]; then
    mkdir -p "${PROFILEPATH}"
  fi
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
# All "home" locations should be set in only this one location, after this
# script is loaded (either in a script or in the entire environment), all
# locations should be set and xdg_base_dir can be used to resolve their locations.

DOTFILES="${DOTFILES:-$(xdg-user-dir DOTFILES)}"
DOTFILES="${DOTFILES:-${HOME}/.dotfiles-rc}"

DOTFILES_PRIVATE="${DOTFILES_PRIVATE:-$(xdg-user-dir DOTFILESPRIVATE)}"
DOTFILES_PRIVATE="${DOTFILES_PRIVATE:-${HOME}/.dotfiles-private}"

export DOTFILES
export DOTFILES_PRIVATE

# XDG Locations

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-${HOME}/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-${HOME}/.local/state}"

# I have to manually read the lines from user-dirs.dirs in order to prepend
# each line with an explicit call to "export"
if [[ -f "${XDG_CONFIG_HOME}/user-dirs.dirs" ]]; then
  while read -r line; do
    if [[ ! ${line} =~ ^"#" && ! "${line}" == "" ]]; then
      eval "export ${line}"
    fi
  done < "${XDG_CONFIG_HOME}/user-dirs.dirs"
fi

## XDG Utility function

function xdg_base_dir() {
  local query
  query=$(echo "${1}" | tr '[:lower:]' '[:upper:]')
  case "${query}" in

    CONFIG | CONFIGHOME)
      echo "${XDG_CONFIG_HOME:-${HOME}/.config}"
      ;;

    CONFIGDIRS)
      echo "${XDG_CONFIG_DIRS:-"/etc/xdg"}"
      ;;

    BIN | BINDIR)
      echo "${XDG_BIN_DIR:-${HOME}/.local/bin}"
      ;;

    DATA | DATAHOME)
      echo "${XDG_DATA_HOME:-${HOME}/.local/share}"
      ;;

    DATADIRS)
      echo "${XGD_DATA_DIRS:-"/usr/local/share/:/usr/share/"}"
      ;;

    CACHE | CACHEHOME)
      echo "${XDG_CACHE_HOME:-${HOME}/.cache}"
      ;;

    STATE | STATEHOME)
      echo "${XDG_STATE_HOME:-${HOME}/.local/state}"
      ;;

    RUNTIME | RUNTIMEDIR)
      echo "${XDG_RUNTIME_DIR:-/run/user/${UID}}"
      ;;

    EXECS | EXECUTABLES | EXES)
      echo "${HOME}/.local/bin"
      ;;

    HOME)
      echo "${HOME}"
      ;;

    HOMEBIN)
      echo "${HOME}/.bin"
      ;;

    "")
      echo "${HOME}"
      ;;

    *)
      xdg-user-dir "${query}"
      ;;

  esac
}

# Bash functions cannot use dashes in their names, use an alias instead to accomplish the same thing
alias xdg-base-dir="xdg_base_dir"

#### START: Virtualization Detection Functions - if we are virtual, what type

function is_vm() {
  if [[ $(systemd-detect-virt --vm || true) == "none" ]]; then
    return 1
  else
    return 0
  fi
}

function is_container() {
  if [[ $(systemd-detect-virt --container || true) == "none" ]]; then
    return 1
  else
    return 0
  fi
}

function is_virtual() {
  if [[ "$(systemd-detect-virt || true)" == "none" ]]; then
    return 1
  else
    return 0
  fi
}

function is_vagrant() {
  if is_vm && [[ "$(grep -i '^vagrant' < /etc/passwd || true)" == "" ]]; then
    return 1
  else
    return 0
  fi
}

function is_wsl() {
  # Are we running on Windows in WSL
  local kernel
  kernel=$(uname -r | tr '[:upper:]' '[:lower:]')
  if [[ "${kernel}" == *"microsoft"* ]]; then
    return 0
  else
    return 1
  fi
}

#### END: Virtualization Detection Functions

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
