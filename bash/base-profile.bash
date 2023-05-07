#!/usr/bin/env bash
# shellcheck disable=2034

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

#### Useful function to check if a command exists

# function to make checking executable existence easier
function command_exists() {
  command -v "$1" &> /dev/null && return 0 || return 1
}

# function to make sourcing an optional item easier
function source_if() {
  if [[ -f $1 ]]; then
    # shellcheck source=/dev/null
    source "$1"
  fi
}

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

export OS_PRIMARY
export OS_SECONDRAY

# Also check to see if we are running on Windows in WSL
kernel=$(uname -r | tr '[:upper:]' '[:lower:]' || true)
if [[ ${kernel} == *"microsoft"* ]]; then
  export IS_WSL="true"
else
  export IS_WSL="false"
fi

# While my dotfiles aren't designed for Mac, put a variable here for later
kernel=$(uname -s | tr '[:upper:]' '[:lower:]' || true)
if [[ ${kernel} == *"darwin"* ]]; then
  export IS_DARWIN="true"
else
  export IS_DARWIN="false"
fi

#### Virtualization Environment Variables - if we are virtual, what type

VIRT_TECH="$(systemd-detect-virt || true)"
export VIRT_TECH

if [[ $(systemd-detect-virt --vm || true) == "none" ]]; then
  IS_VM="false"
else
  IS_VM="true"
fi

export IS_VM

if [[ $(systemd-detect-virt --container || true) == "none" ]]; then
  IS_CONTAINER="false"
else
  IS_CONTAINER="true"
fi

export IS_CONTAINER

if [[ ${VIRT_TECH} == "none" ]]; then
  IS_VIRTUAL="false"
else
  IS_VIRTUAL="true"
fi

export IS_VIRTUAL

if [[ "$(grep -i '^vagrant' < /etc/passwd || true)" == "" ]]; then
  IS_VAGRANT="false"
else
  IS_VAGRANT="true"
fi

export IS_VAGRANT

#### Color variables - not to be exported, just loaded into the environment

## Text effects
text_reset="$(tput sgr0)"
text_normal="$(tput sgr0)"
text_clear="$(tput sgr0)"

text_bold="$(tput bold)"
text_dim="$(tput dim)"

text_under="$(tput smul)"
text_underscore="$(tput smul)"
text_clear_underscore="$(tput rmul)"
text_clear_under="$(tput rmul)"

text_standout="$(tput smso)"
text_clear_standout="$(tput rmso)"
text_italic="$(tput sitm)"
text_clear_italic="$(tput ritm)"

text_reverse="$(tput rev)"
text_blink="$(tput blink)"

## Colors

text_black="$(tput setaf 0)"
text_red="$(tput setaf 1)"
text_green="$(tput setaf 2)"
text_yellow="$(tput setaf 3)"
text_blue="$(tput setaf 4)"
text_magenta="$(tput setaf 5)"
text_cyan="$(tput setaf 6)"
text_white="$(tput setaf 7)"

text_bright_black="${text_bold}${text_black}"
text_bright_red="${text_bold}${text_red}"
text_bright_green="${text_bold}${text_green}"
text_bright_yellow="${text_bold}${text_yellow}"
text_bright_blue="${text_bold}${text_blue}"
text_bright_magenta="${text_bold}${text_magenta}"
text_bright_cyan="${text_bold}${text_cyan}"
text_bright_white="${text_bold}${text_white}"

text_dim_black="${text_dim}${text_black}"
text_dim_red="${text_dim}${text_red}"
text_dim_green="${text_dim}${text_green}"
text_dim_yellow="${text_dim}${text_yellow}"
text_dim_blue="${text_dim}${text_blue}"
text_dim_magenta="${text_dim}${text_magenta}"
text_dim_cyan="${text_dim}${text_cyan}"
text_dim_white="${text_dim}${text_white}"

# Alternate color names for some of the colors names

text_pink="${text_bright_magenta}" # bright magenta
text_purple="${text_magenta}"      # regular magenta
text_orange="${text_yellow}"       # regular yellow

## Background colors

text_bg_black="$(tput setab 0)"
text_bg_red="$(tput setab 1)"
text_bg_green="$(tput setab 2)"
text_bg_yellow="$(tput setab 3)"
text_bg_blue="$(tput setab 4)"
text_bg_magenta="$(tput setab 5)"
text_bg_cyan="$(tput setab 6)"
text_bg_white="$(tput setab 7)"

text_bg_bright_black="$(tput setab 8)"
text_bg_bright_red="$(tput setab 9)"
text_bg_bright_green="$(tput setab 10)"
text_bg_bright_yellow="$(tput setab 11)"
text_bg_bright_blue="$(tput setab 12)"
text_bg_bright_magenta="$(tput setab 13)"
text_bg_bright_cyan="$(tput setab 14)"
text_bg_bright_white="$(tput setab 15)"

# Dim colors not supported for background

# Alternate color names for some of the background colors names

text_bg_pink="${text_bg_bright_magenta}" # bright magenta
text_bg_purple="${text_bg_magenta}"      # regular magenta
text_bg_orange="${text_bg_yellow}"       # regular yellow

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
  if [[ ${IS_WSL:-false} == "true" ]]; then
    return 0
  else
    return 1
  fi
}

# Function to easily add a path (this version adds to the end)
# http://superuser.com/a/39995
function path_append() {
  if [[ -d $1 ]] && [[ ":${PATH}:" != *":$1:"* ]]; then
    export PATH="${PATH:+"${PATH}:"}$1"
  fi
}

function manpath_append() {
  if [[ -d $1 ]] && [[ ":${MANPATH}:" != *":$1:"* ]]; then
    export MANPATH="${MANPATH:+"${MANPATH}:"}$1"
  fi
}

# Function to easily add a path (this version adds to the beginning)
# http://superuser.com/a/39995
function path_prepend() {
  if [[ -d $1 ]] && [[ ":${PATH}:" != *":$1:"* ]]; then
    export PATH="$1:${PATH}"
  fi
}

function manpath_prepend() {
  if [[ -d $1 ]] && [[ ":${MANPATH}:" != *":$1:"* ]]; then
    export MANPATH="$1:${MANPATH}"
  fi
}

# Used to call a function or command and rather than fail due to 'set -e' in the
# current shell, grab its exit code.  This is usefull\necessary when you want to
# gracefully handle the result of a command that would otherwise stop execution
# of the script due to 'set -e' being turned on.
#
# Usage: Call this function just prior to a bash function or command you wish to
# capture the exit code for.  Inputs for the second function can be passed as
# usual and they will flow through to the execution of the command.
#
# get_exist_code some_function input1 input2
#
# Afterward you can then check the ${EXIT_CODE} variable and handle it however
# you wish.
get_exit_code() {
  EXIT_CODE=0
  # We first disable errexit in the current shell
  set +e
  (
    # Then we set it again inside a subshell
    set -e
    # ...and run the function
    "$@"
  )
  # shellcheck disable=2034
  EXIT_CODE=$?
  # And finally turn errexit back on in the current shell
  set -e
}

# Check if a string exists in an array of elements\strings
#
# Say you have an array like:  DISTROS=('debian' 'ubuntu' 'arch')
# If you wanted to verify whether the string 'debian' exists in that array, you
# could use the following:
#
# get_exit_code contains_element "debian" "${DISTROS[@]}"
# if [[ ${EXIT_CODE} -eq 0 ]]
# then
#   <string does exist in array, code goes here>
# fi
#
contains_element() {
  for e in "${@:2}"; do
    [[ ${e} == "$1" ]] && break
  done
}

# The following two functions allow a script to check if a package exists in
# the package archives.  Not this does not check INSTALLED packages but the
# list of all available packages.  The first version, 'apt_package_exists'
# checks the current machine, while the other uses arch-chroot to check.
#
# This should be used with the get_exist_code function above.  Like so:
#
# get_exit_code apt_package_exists "some-package"
# if [[ ${EXIT_CODE} -eq 0 ]]
# then
#   <package exists, code goes here>
# fi
#
apt_package_exists() {
  apt-cache show "$1" &> /dev/null
  return $?
}

# Works just like apt_package_exists but does does a chroot first.  This is
# mostly usable in installation scenarios.  By default it chroot's to /mnt
# but you can pass a second argument to override that.  The first argument is
# the package to check for.
#
arch_chroot_apt_package_exists() {
  arch-chroot "${2:-/mnt}" apt-cache show "$1" &> /dev/null
  return $?
}

# Two methods to check whether we are running as root or not.  The first simply
# returns a value indicating whether we are running as root or not, while the
# second will print out an error and exit.
#
check_root() {
  local user_id
  user_id=$(id -u)
  if [[ "${user_id}" == "0" ]]; then
    return 0
  fi
  return 1
}

check_root_with_error() {
  get_exit_code check_root
  if [[ ${EXIT_CODE} -ne 0 ]]; then
    local error_message=${1:-"ERROR!  You must execute this script as the 'root' user."}
    local error_code=${2:-"1"}

    local T_COLS
    T_COLS=$(tput cols)
    T_COLS=$((T_COLS - 1))

    # shellcheck disable=2154
    echo -e "${text_red}${error_message}${text_reset}\n" | fold -sw "${T_COLS}"
    exit "${error_code}"
  fi
}

unset uname
unset kernel
