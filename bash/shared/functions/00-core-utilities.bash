#!/usr/bin/env bash

# Bash strict mode
([[ -n ${ZSH_EVAL_CONTEXT} && ${ZSH_EVAL_CONTEXT} =~ :file$ ]] ||
 [[ -n ${BASH_VERSION} ]] && (return 0 2>/dev/null)) && SOURCED=true || SOURCED=false
if ! ${SOURCED}
then
  set -o errexit # same as set -e
  set -o nounset # same as set -u
  set -o errtrace # same as set -E
  set -o pipefail
  set -o posix
  #set -o xtrace # same as set -x, turn on for debugging

  shopt -s inherit_errexit
  shopt -s extdebug
  IFS=$(printf '\n\t')
fi
# END Bash scrict mode

function is_mac() {
  if [[ ${OS_PRIMARY:-linux} == "macos" ]]
  then
    return 0
  else
    return 1
  fi
}

function is_linux() {
  if [[ ${OS_PRIMARY:-linux} == "linux" ]]
  then
    return 0
  else
    return 1
  fi
}

function is_windows() {
  if [[ ${IS_WSL:-false} == "true" ]]
  then
    return 0
  else
    return 1
  fi
}

# Function to easily add a path (this version adds to the end)
# http://superuser.com/a/39995
function path_append() {
  if [[ -d $1 ]] && [[ ":${PATH}:" != *":$1:"* ]]
  then
    export PATH="${PATH:+"${PATH}:"}$1"
  fi
}

function manpath_append() {
  if [[ -d $1 ]] && [[ ":${MANPATH}:" != *":$1:"* ]]
  then
    export MANPATH="${MANPATH:+"${MANPATH}:"}$1"
  fi
}

# Function to easily add a path (this version adds to the beginning)
# http://superuser.com/a/39995
function path_prepend() {
  if [[ -d $1 ]] && [[ ":${PATH}:" != *":$1:"* ]]
  then
    export PATH="$1:${PATH}"
  fi
}

function manpath_prepend() {
  if [[ -d $1 ]] && [[ ":${MANPATH}:" != *":$1:"* ]]
  then
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
    set -e;
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
  for e in "${@:2}"
  do
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
# mostly usable in installation scenarios.  By default it chroots to /mnt
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
  if [[ "${user_id}" == "0" ]]
  then
    return 0
  fi
  return 1
}

check_root_with_error() {
  get_exit_code check_root
  if [[ ${EXIT_CODE} -ne 0 ]]
  then
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
