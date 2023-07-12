#!/usr/bin/env bash
# shellcheck disable=2034
#
# Skipping 2034 because this script specifically is loading variables into the environment only,
# we do NOT want to export them but instead use them "within" the shell instance only.

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

#### START: Basic Utilities

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

#### END: Basic Utilities

#### START: Array Utilities

# Used to call a function or command and rather than fail due to 'set -e' in the
# current shell, grab its exit code.  This is useful\necessary when you want to
# gracefully handle the result of a command that would otherwise stop execution
# of the script due to 'set -e' being turned on.
#
# Usage: Call this function just prior to a bash function or command you wish to
# capture the exit code for.  Inputs for the second function can be passed as
# usual and they will flow through to the execution of the command.
#
# get_exit_code some_function input1 input2
#
# Afterward you can then check the ${EXIT_CODE} variable and handle it however
# you wish.
function get_exit_code() {
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
function contains_element() {
  for e in "${@:2}"; do
    [[ ${e} == "$1" ]] && break
  done
}

#### END: Array Utilities

#### START: APT Package Utilities

# The following two functions allow a script to check if a package exists in
# the package archives.  Note this does not check INSTALLED packages but the
# list of all available packages.  The first version, 'apt_package_exists'
# checks the current machine, while the other uses arch-chroot to check.
#
# This should be used like so:
#
# if apt_package_exists "my-package"; then
# then
#   <package exists, code goes here>
# fi
#
function apt_package_exists() {
  local apt
  apt=$(apt-cache -q=2 show "$1" 2>&1 | head -n 1 || true)
  if [[ "${apt}" == Package* ]]; then
    return 0
  else
    return 1
  fi
}

# Works just like apt_package_exists but does a chroot first.  This is
# mostly usable in installation scenarios.  By default it chroot's to /mnt
# but you can pass a second argument to override that.  The first argument is
# the package to check for.
#
function arch_chroot_apt_package_exists() {
  local apt
  apt=$(arch-chroot /mnt apt-cache -q=2 show "$1" 2>&1 | head -n 1 || true)
  if [[ "${apt}" == Package* ]]; then
    return 0
  else
    return 1
  fi
}

# Whether a package is actually installed
function apt_package_installed() {
  local pkg_count
  pkg_count=$(dpkg --get-selections | grep -c "${1}")
  if [[ ${pkg_count} -eq 0 ]]; then
    return 1
  else
    return 0
  fi
}

# chroot version of the above function
function arch_chroot_apt_package_installed() {
  local pkg_count
  pkg_count=$(arch-chroot "${2:-/mnt}" dpkg --get-selections | grep -c "${1}")
  if [[ ${pkg_count} -eq 0 ]]; then
    return 1
  else
    return 0
  fi
}

#### END: APT Package Utilities

#### START: Path Utilities

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

#### END: Path Utilities

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

#### START: Check Root Functions

# Two methods to check whether we are running as root or not.  The first simply
# returns a value indicating whether we are running as root or not, while the
# second will print out an error and exit.
function check_root() {
  local user_id
  user_id=$(id -u)
  if [[ ${user_id} -ne 0 ]]; then
    return 0
  fi
  return 1
}

function check_root_with_error() {
  local user_id
  user_id=$(id -u)

  if [[ ${user_id} -ne 0 ]]; then
    local error_message=${1:=""}
    if [[ "${error_message}" == "" ]]; then
      error_message="ERROR!  You must execute this script as the 'root' user."
    fi
    local error_code=${2:="1"}

    local T_COLS
    T_COLS=$(tput cols)
    T_COLS=$((T_COLS - 1))

    # Only here for portability, this method can be copy/pasted from here to anywhere else
    local RED
    local RESET
    RED="$(tput setaf 1)"
    RESET="$(tput sgr0)"

    # shellcheck disable=2154
    echo -e "${RED}${error_message}${RESET}\n" | fold -sw "${T_COLS}"
    exit "${error_code}"
  fi
}

#### END: Check Root Functions

#### START: Terminal Text Manipulation And Color Variables

## Text effects

text_bold="$(tput bold)"
#text_bold_off="$(tput bold)"
text_dim="$(tput dim)"

text_under="$(tput smul)"
text_underscore="$(tput smul)"
text_underscore_off="$(tput rmul)"
text_under_off="$(tput rmul)"

text_standout="$(tput smso)"
text_standout_off="$(tput rmso)"
text_italic="$(tput sitm)"
text_italic_off="$(tput ritm)"

text_reverse="$(tput rev)"
text_secure="$(tput invis)"
text_conceal="$(tput invis)"
text_blink="$(tput blink)"

: "$(tput sgr0)"

# text_subscript="$(tput ssubm)"       # Not many terminals support this
# text_subscript_off="$(tput rsubm)"   # Not many terminals support this
# text_superscript="$(tput ssupm)"     # Not many terminals support this
# text_superscript_off="$(tput rsupm)" # Not many terminals support this

## Text Colors

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

## Alternate color names for some of the colors

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

# Alternate color names for some of the background colors

text_bg_pink="${text_bg_bright_magenta}" # bright magenta
text_bg_purple="${text_bg_magenta}"      # regular magenta
text_bg_orange="${text_bg_yellow}"       # regular yellow

text_reset="$(tput sgr0)"
text_normal="$(tput sgr0)"
text_clear="$(tput sgr0)"

#### END: Terminal Text Manipulation And Color Variables

#### START: Terminal Print Functions

function print_blank_line() {
  echo ""
}

function print_separator() {
  print_line "$@"
}

function print_line() {
  local T_COLS
  T_COLS=$(tput cols)
  printf "%${T_COLS}s\n" | tr ' ' '-'
}

function print_white() {
  print_status "$@"
}

function print_status() {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_reset}$1${text_reset}" | fold -sw "${T_COLS}"
}

function print_bold() {
  print_info "$@"
}

function print_info() {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_bold}$1${text_reset}" | fold -sw "${T_COLS}"
}

function print_yellow() {
  print_warning "$@"
}

function print_warning() {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_yellow}$1${text_reset}" | fold -sw "${T_COLS}"
}

function print_green() {
  print_success "$@"
}

function print_success() {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_green}$1${text_reset}" | fold -sw "${T_COLS}"
}

function print_red() {
  print_error "$@"
}

function print_error() {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_red}$1${text_reset}" | fold -sw "${T_COLS}"
}

function print_blue() {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_blue}$1${text_reset}" | fold -sw "${T_COLS}"
}

function print_magenta {
  print_heading "$@"
}

function print_heading {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_magenta}$1${text_reset}" | fold -sw "${T_COLS}"
}

function print_cyan {
  local T_COLS
  T_COLS=$(tput cols)
  T_COLS=$((T_COLS - 1))
  echo -e "${text_cyan}$1${text_reset}" | fold -sw "${T_COLS}"
}

function pause_output() {
  print_line
  read -re -sn 1 -p "Press enter to continue..."
}

function error_msg() {
  print_error "$1"
  if [[ ${2:-} != "" ]]; then
    exit "$2"
  else
    exit 1
  fi
}

#### END: Terminal Print Functions
