#!/usr/bin/env bash
# shellcheck disable=SC2139

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

git_cmd=$(git-exe)

alias g="${git_cmd}"
alias get="${git_cmd}"

alias gs="${git_cmd} status"
alias gss="${git_cmd} status -sb"

alias gpu="${git_cmd} push"
alias gpush="${git_cmd} push"

alias gp="${git_cmd} pull --all --ff-only"
alias gpl="${git_cmd} pull --all --ff-only"
alias gpull="${git_cmd} pull --all --ff-only"

alias gf="${git_cmd} fetch --all --tags"
alias ga="git-add-alias"
alias gc="${git_cmd} commit"
alias gco="${git_cmd} checkout"
alias gcl="${git_cmd} clone"
alias gd="${git_cmd} diff"
alias gds="${git_cmd} diff --cached"
alias gdc="${git_cmd} diff --cached"
alias gdt="${git_cmd} difftool -y"
alias gdts="${git_cmd} difftool -y --cached"
alias gdtc="${git_cmd} difftool -y --cached"
alias gmt="${git_cmd} mergetool -y"
alias gsw="git-switch-alias"
alias gr="${git_cmd} restore"

# Since I use main and develop branches so much, add specific aliases to switch
# to those branches
alias gsm="${git_cmd} switch main"
alias gsd="${git_cmd} switch develop"
# I also also merge develop into main quite a lot
alias gmd="${git_cmd} merge develop --ff-only"
alias gmm="${git_cmd} merge main --ff-only"

alias gexp="${git_cmd} archive --format zip --output"

alias glog="${git_cmd} log --graph --pretty=oneline --abbrev-commit"

unset git_cmd
