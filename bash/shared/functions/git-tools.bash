#!/usr/bin/env bash

function git-branch-name() {
    if [[ $(in-a-git-repo) == 1 ]]; then
        echo $(git rev-parse --abbrev-ref HEAD)
    else
        echo "Not a git repo."
    fi
}

function in-a-git-repo() {
    if [[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == 'true' ]]; then
        echo 1
    else
        echo 0
    fi
}

function git-root-path() {
    if [[ $(in-a-git-repo) == 1 ]]; then
        echo "$(git rev-parse --show-toplevel)"
    else
        echo "$(pwd)"
    fi
}

function cd-to-git-root-path() {
    if [[ $(in-a-git-repo) == 1 ]]; then
        if [[ -n $1 ]]; then
            cd "$(git rev-parse --show-cdup)/$1"
        else
            cd "$(git rev-parse --show-cdup)"
        fi
    fi
}

function git-remove-missing-files() {
    git ls-files -d -z | xargs -0 git update-index --remove
}
