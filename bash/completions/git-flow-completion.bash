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

#
# git-flow-completion
# ===================
#
# Bash completion support for [git-flow (AVH Edition)](http://github.com/petervanderdoes/gitflow)
#
# The contained completion routines provide support for completing:
#
#  * git-flow init and version
#  * feature, bugfix, hotfix and release branches
#  * remote feature, bugfix, hotfix and release branch names
#
#
# Installation
# ------------
#
# To achieve git-flow completion nirvana:
#
#  0. Install git-completion.
#
#  1. Install this file. Either:
#
#     a. Place it in a `bash-completion.d` folder:
#
#        * /etc/bash-completion.d
#        * /usr/local/etc/bash-completion.d
#        * ~/bash-completion.d
#
#     b. Or, copy it somewhere (e.g. ~/.git-flow-completion.sh) and put the following line in
#        your .bashrc:
#
#            source ~/.git-flow-completion.sh
#
#  2. If you are using Git < 1.7.1: Edit git-completion.sh and add the following line to the giant
#     $command case in _git:
#
#         flow)        _git_flow ;;
#
#
# The Fine Print
# --------------
#
# Author:
# Copyright 2012-2013 Peter van der Does.
#
# Original Author:
# Copyright (c) 2011 [Justin Hileman](http://justinhileman.com)
#
# Distributed under the [MIT License](http://creativecommons.org/licenses/MIT/)

__git_flow_config_file_options="
    --local --global --system --file=
    "

_git_flow() {
  local subcommands="init feature bugfix release hotfix support help version config finish delete publish rebase"
  local subcommand
  subcommand="$(__git_find_on_cmdline "${subcommands}")"
  if [[ -z "${subcommand}" ]]; then
    __gitcomp "${subcommands}"
    return
  fi

  case "${subcommand}" in
    init)
      __git_flow_init
      return
      ;;
    feature)
      __git_flow_feature
      return
      ;;
    bugfix)
      __git_flow_bugfix
      return
      ;;
    release)
      __git_flow_release
      return
      ;;
    hotfix)
      __git_flow_hotfix
      return
      ;;
    support)
      __git_flow_support
      return
      ;;
    config)
      __git_flow_config
      return
      ;;
    *)
      COMPREPLY=()
      ;;
  esac
}

__git_flow_init() {
  local subcommands="help"
  local subcommand
  subcommand="$(__git_find_on_cmdline "${subcommands}")"
  if [[ -z "${subcommand}" ]]; then
    __gitcomp "${subcommands}"
  fi

  case "${cur}" in
    --*)
      __gitcomp "
                --nodefaults --defaults
                --noforce --force
                ${__git_flow_config_file_options}
                "
      return
      ;;

    *) ;;

  esac
}

__git_flow_feature() {
  local subcommands="list start finish publish track diff rebase checkout pull help delete rename"
  local subcommand
  subcommand="$(__git_find_on_cmdline "${subcommands}")"

  if [[ -z "${subcommand}" ]]; then
    __gitcomp "${subcommands}"
    return
  fi

  case "${subcommand}" in
    pull)
      __gitcomp_nl "$(__git_remotes || true)"
      return
      ;;
    checkout)
      __gitcomp_nl "$(__git_flow_list_local_branches 'feature' || true)"
      return
      ;;
    delete)
      case "${cur}" in
        --*)
          __gitcomp "
                    --noforce --force
                    --noremote --remote
                    "
          return
          ;;

        *) ;;

      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'feature' || true)"
      return
      ;;
    finish)
      case "${cur}" in
        --*)
          __gitcomp "
                    --nofetch --fetch
                    --norebase --rebase
                    --nopreserve-merges --preserve-merges
                    --nokeep --keep
                    --keepremote
                    --keeplocal
                    --noforce_delete --force_delete
                    --nosquash --squash
                    --no-ff
                "
          return
          ;;

        *) ;;

      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'feature' || true)"
      return
      ;;
    diff)
      __gitcomp_nl "$(__git_flow_list_local_branches 'feature' || true)"
      return
      ;;
    rebase)
      case "$cur" in
        --*)
          __gitcomp "
                    --nointeractive --interactive
                    --nopreserve-merges --preserve-merges
                "
          return
          ;;

        *) ;;

      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'feature' || true)"
      return
      ;;
    publish)
      __gitcomp_nl "$(__git_flow_list_branches 'feature' || true)"
      return
      ;;
    track)
      __gitcomp_nl "$(__git_flow_list_branches 'feature' || true)"
      return
      ;;
    *)
      COMPREPLY=()
      ;;
  esac
}

__git_flow_bugfix() {
  local subcommands="list start finish publish track diff rebase checkout pull help delete rename"
  local subcommand="$(__git_find_on_cmdline "$subcommands")"

  if [ -z "$subcommand" ]; then
    __gitcomp "$subcommands"
    return
  fi

  case "$subcommand" in
    pull)
      __gitcomp_nl "$(__git_remotes)"
      return
      ;;
    checkout)
      __gitcomp_nl "$(__git_flow_list_local_branches 'bugfix')"
      return
      ;;
    delete)
      case "$cur" in
        --*)
          __gitcomp "
                    --noforce --force
                    --noremote --remote
                    "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'bugfix')"
      return
      ;;
    finish)
      case "$cur" in
        --*)
          __gitcomp "
                    --nofetch --fetch
                    --norebase --rebase
                    --nopreserve-merges --preserve-merges
                    --nokeep --keep
                    --keepremote
                    --keeplocal
                    --noforce_delete --force_delete
                    --nosquash --squash
                    --no-ff
                "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'bugfix')"
      return
      ;;
    diff)
      __gitcomp_nl "$(__git_flow_list_local_branches 'bugfix')"
      return
      ;;
    rebase)
      case "$cur" in
        --*)
          __gitcomp "
                    --nointeractive --interactive
                    --nopreserve-merges --preserve-merges
                "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'bugfix')"
      return
      ;;
    publish)
      __gitcomp_nl "$(__git_flow_list_branches 'bugfix')"
      return
      ;;
    track)
      __gitcomp_nl "$(__git_flow_list_branches 'bugfix')"
      return
      ;;
    *)
      COMPREPLY=()
      ;;
  esac
}

__git_flow_release() {
  local subcommands="list start finish track publish help delete"
  local subcommand="$(__git_find_on_cmdline "$subcommands")"
  if [ -z "$subcommand" ]; then
    __gitcomp "$subcommands"
    return
  fi

  case "$subcommand" in
    finish)
      case "$cur" in
        --*)
          __gitcomp "
                    --nofetch --fetch
                    --sign
                    --signingkey
                    --message
                    --nomessagefile --messagefile=
                    --nopush --push
                    --nokeep --keep
                    --keepremote
                    --keeplocal
                    --noforce_delete --force_delete
                    --notag --tag
                    --nonobackmerge --nobackmerge
                    --nosquash --squash
                    --squash-info
                "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'release')"
      return
      ;;
    rebase)
      case "$cur" in
        --*)
          __gitcomp "
                    --nointeractive --interactive
                    --nopreserve-merges --preserve-merges
                "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'release')"
      return
      ;;
    delete)
      case "$cur" in
        --*)
          __gitcomp "
                    --noforce --force
                    --noremote --remote
                    "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'release')"
      return
      ;;
    publish)
      __gitcomp_nl "$(__git_flow_list_branches 'release')"
      return
      ;;
    track)
      __gitcomp_nl "$(__git_flow_list_branches 'release')"
      return
      ;;
    start)
      case "$cur" in
        --*)
          __gitcomp "
                    --nofetch --fetch
                "
          return
          ;;
      esac
      return
      ;;
    *)
      COMPREPLY=()
      ;;
  esac

}

__git_flow_hotfix() {
  local subcommands="list start finish track publish help delete rename"
  local subcommand="$(__git_find_on_cmdline "$subcommands")"
  if [ -z "$subcommand" ]; then
    __gitcomp "$subcommands"
    return
  fi

  case "$subcommand" in
    finish)
      case "$cur" in
        --*)
          __gitcomp "
                    --nofetch --fetch
                    --sign
                    --signingkey
                    --message
                    --nomessagefile --messagefile=
                    --nopush --push
                    --nokeep --keep
                    --keepremote
                    --keeplocal
                    --noforce_delete --force_delete
                    --notag --tag
                    --nonobackmerge --nobackmerge
                    --nosquash --squash
                    --squash-info
                "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'hotfix')"
      return
      ;;
    rebase)
      case "$cur" in
        --*)
          __gitcomp "
                    --nointeractive --interactive
                    --nopreserve-merges --preserve-merges
                "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'hotfix')"
      return
      ;;
    delete)
      case "$cur" in
        --*)
          __gitcomp "
                    --noforce --force
                    --noremote --remote
                    "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'hotfix')"
      return
      ;;
    publish)
      __gitcomp_nl "$(__git_flow_list_branches 'hotfix')"
      return
      ;;
    track)
      __gitcomp_nl "$(__git_flow_list_branches 'hotfix')"
      return
      ;;
    start)
      case "$cur" in
        --*)
          __gitcomp "
                    --nofetch --fetch
                "
          return
          ;;
      esac
      return
      ;;
    *)
      COMPREPLY=()
      ;;
  esac
}

__git_flow_support() {
  local subcommands="list start help"
  local subcommand="$(__git_find_on_cmdline "$subcommands")"
  if [ -z "$subcommand" ]; then
    __gitcomp "$subcommands"
    return
  fi

  case "$subcommand" in
    start)
      case "$cur" in
        --*)
          __gitcomp "
                    --nofetch --fetch
                "
          return
          ;;
      esac
      return
      ;;
    rebase)
      case "$cur" in
        --*)
          __gitcomp "
                    --nointeractive --interactive
                    --nopreserve-merges --preserve-merges
                "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches 'support')"
      return
      ;;
    *)
      COMPREPLY=()
      ;;
  esac
}

__git_flow_config() {
  local subcommands="list set base"
  local subcommand="$(__git_find_on_cmdline "$subcommands")"
  if [ -z "$subcommand" ]; then
    __gitcomp "$subcommands"
    return
  fi

  case "$subcommand" in
    set)
      case "$cur" in
        --*)
          __gitcomp "
                        $__git_flow_config_file_options
                    "
          return
          ;;
      esac
      __gitcomp "
            master develop
            feature bugfix hotfix release support
            versiontagprefix
            "
      return
      ;;
    base)
      case "$cur" in
        --*)
          __gitcomp "
                        set get
                    "
          return
          ;;
      esac
      __gitcomp_nl "$(__git_flow_list_local_branches)"
      return
      ;;
    *)
      COMPREPLY=()
      ;;
  esac
}

__git_flow_prefix() {
  case "$1" in
    feature | bugfix | release | hotfix | support)
      git config "gitflow.prefix.$1" 2> /dev/null || echo "$1/"
      return
      ;;
  esac
}

__git_flow_list_local_branches() {
  if [ -n "$1" ]; then
    local prefix="$(__git_flow_prefix $1)"
    git for-each-ref --shell --format="ref=%(refname:short)" refs/heads/$prefix \
      | while read -r entry; do
        eval "$entry"
        ref="${ref#$prefix}"
        echo "$ref"
      done | sort
  else
    git for-each-ref --format="ref=%(refname:short)" refs/heads/ | sort

  fi
}

__git_flow_list_remote_branches() {
  local prefix="$(__git_flow_prefix $1)"
  local origin="$(git config gitflow.origin 2> /dev/null || echo "origin")"
  git for-each-ref --shell --format='%(refname:short)' refs/remotes/$origin/$prefix \
    | while read -r entry; do
      eval "$entry"
      ref="${ref##$prefix}"
      echo "$ref"
    done | sort
}

__git_flow_list_branches() {
  local origin="$(git config gitflow.origin 2> /dev/null || echo "origin")"
  if [ -n "$1" ]; then
    local prefix="$(__git_flow_prefix $1)"
    git for-each-ref --shell --format="ref=%(refname:short)" refs/heads/$prefix refs/remotes/$origin/$prefix \
      | while read -r entry; do
        eval "$entry"
        ref="${ref##$prefix}"
        echo "$ref"
      done | sort
  else
    git for-each-ref --format="%(refname:short)" refs/heads/ refs/remotes/$origin | sort
  fi
}

# alias __git_find_on_cmdline for backwards compatibility
if [ -z "$(type -t __git_find_on_cmdline)" ]; then
  alias __git_find_on_cmdline=__git_find_subcommand
fi
