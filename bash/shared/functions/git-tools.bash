#!/usr/bin/env bash

function __get_git_branch_name {
    local branch_pattern="^## ([[:graph:]]+)\.\.\.[[:graph:]]+ ?.*"
    local alt_branch_pattern="^## Initial commit on ([[:graph:]]+)"
    local local_branch_pattern="^## ([[:graph:]]+)"

    local git_branch="unknown"
    if [[ "$1" =~ $branch_pattern ]]; then
        git_branch=${BASH_REMATCH[1]}
    elif [[ "$1" =~ $alt_branch_pattern ]]; then
        git_branch=${BASH_REMATCH[1]}
    elif [[ "$1" =~ $local_branch_pattern ]]; then
        git_branch=${BASH_REMATCH[1]}
    fi
    echo "$git_branch"
}

function git-branch-name {
    local git_status="$(git status -b --porcelain 2> /dev/null)"
    local branch_name=$(__get_git_branch_name "$git_status")
    echo "$branch_name"
}

function in-a-git-repo {
  if [[ -e "$(git rev-parse --git-dir 2> /dev/null)" ]]; then
    echo 1
  else
    echo 0
  fi
}

function git-root-path {
    return "$(git rev-parse --show-toplevel 2> /dev/null)"
}

function git-remove-missing-files {
    git ls-files -d -z | xargs -0 git update-index --remove
}
