#!/usr/bin/env bash

function git-branch-name() {
  if in-a-git-repo; then
    git rev-parse --abbrev-ref HEAD
  else
    echo "Not a git repo."
  fi
}

function in-a-git-repo() {
  if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]]; then
    return 0
  else
    return 1
  fi
}

function git-root-path() {
  if in-a-git-repo; then
    git rev-parse --show-toplevel
  else
    pwd
  fi
}

function cd-to-git-root-path() {
  if in-a-git-repo; then
    if [[ -n $1 ]]; then
      cd "$(git rev-parse --show-cdup)/$1" || return
    else
      cd "$(git rev-parse --show-cdup)" || return
    fi
  fi
}

function git-get-remote-user() {
  local remote="origin"
  if [[ -n $1 ]]; then
    remote=$1
  fi

  if in-a-git-repo; then
    git remote get-url "$remote" | sed -E 's@^.+(:|/)([^/]+)/.+$@\2@'
  else
    ""
  fi
}

function git-get-remote-name() {
  local remote="origin"
  if [[ -n $1 ]]; then
    remote=$1
  fi

  if in-a-git-repo; then
    git remote get-url "$remote" | sed -E 's@^.+[:/][^/]+.+/([^.]+)(.git)?$@\1@'
  else
    ""
  fi
}

function git-get-remote-protocol() {
  local remote="origin"
  if [[ -n $1 ]]; then
    remote=$1
  fi

  if in-a-git-repo; then
    git remote get-url "$remote" | sed -E 's@^((git|ssh|https))[\@:+].+$@\1@'
  else
    ""
  fi
}

function git-get-remote-service() {
  local remote="origin"
  if [[ -n $1 ]]; then
    remote=$1
  fi

  if in-a-git-repo; then
    git remote get-url "$remote" | sed -E 's@^(?:(?:git|ssh|https))[:+\@](?://)?(?:.+?[\@])?(?:git-)?(.+?)[\@:/.].+$@\1@'
  else
    ""
  fi
}

function git-stage-removed-files() {
  git ls-files -d -z | xargs -0 git update-index --remove
}
