#!/usr/bin/env bash

git_cmd="git"
if command_exists hub; then
    git_cmd="hub"
    eval "$(hub alias -s)"
fi

alias g="$git_cmd"
alias get="$git_cmd"

alias gs="$git_cmd status"
alias gss="$git_cmd status -sb"

alias gp="$git_cmd pull"

alias gexp='$git_cmd archive --format zip --output'

alias gll='$git_cmd log --graph --pretty=oneline --abbrev-commit'

unset git_cmd
