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
# END Bash scrict mode

function vagrant_cmd() {
  # Check we are in a directory with a Vagrantfile
  if [[ ! -f "./Vagrantfile" ]]; then
    error_msg "Not in a directory with a Vagrantfile!"
  fi

  vagrant "$@"
}

function vagrant_provision() {
  local provisioner="main"
  if [[ $# -eq 0 ]]; then
    print_warning "No provisioner given, using default of 'main'"
  else
    provisioner="$1"
  fi

  vagrant_cmd provision --provision-with "${provisioner}"
}

alias v='vagrant_cmd'
alias vp='vagrant_provision'
alias vc='vagrant_cmd ssh'
alias vssh='vagrant_cmd ssh'
alias vu='vagrant_cmd up'
alias vh='vagrant_cmd halt'
alias vd='vagrant_cmd destroy'
alias vss='vagrant_cmd snapshot save'
alias vsr='vagrant_cmd snapshot restore'
alias vsd='vagrant_cmd snapshot destroy'

### For Packer

function packer_build() {
  # Check we are in a directory packer directory
  if [[ ! -f "./build.bash" ]]; then
    error_msg "Not in a packer build directory!"
  fi

  ./build.bash "$@"
}

function packer_clean() {
  # Check we are in a directory packer directory
  if [[ ! -f "./clean.bash" ]]; then
    error_msg "Not in a packer build or test directory!"
  fi

  ./clean.bash "$@"
}

function packer_test() {
  # Check we are in a directory packer directory
  if [[ ! -f "./test.bash" ]]; then
    error_msg "Not in a packer test directory!"
  fi

  "./test.bash" "$@"
}

function packer_run_all_tests() {
  # Check we are in a directory packer directory
  if [[ ! -f "./run-all-tests.bash" ]]; then
    error_msg "Not in a packer test directory!"
  fi

  "./run-all-tests.bash" "$@"
}

alias pb='packer_build'
alias pbh='packer_build -h'
alias pc='packer_clean'
alias pch='packer_clean -h'
alias pt='packer_test'
alias pth='packer_test -h'
alias pall='packer_run_all_tests'
