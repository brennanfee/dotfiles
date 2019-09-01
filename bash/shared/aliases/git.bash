#!/usr/bin/env bash
# shellcheck disable=SC2139

git_cmd=$(git-exe)

alias g="$git_cmd"
alias get="$git_cmd"

alias gs="$git_cmd status"
alias gss="$git_cmd status -sb"

alias gpu="$git_cmd push --tags"
alias gpl="$git_cmd pull"
alias gf="$git_cmd fetch --all --tags"
alias ga="git-add-alias"
alias gc="$git_cmd commit"
alias gco="$git_cmd checkout"
alias gd="$git_cmd diff"
alias gds="$git_cmd diff --cached"
alias gdc="$git_cmd diff --cached"
alias gdt="$git_cmd difftool -y"
alias gdts="$git_cmd difftool -y --cached"
alias gdtc="$git_cmd difftool -y --cached"
alias gmt="$git_cmd mergetool -y"
alias gsw="git-switch-alias"
alias gr="$git_cmd restore"

alias gexp="$git_cmd archive --format zip --output"

alias gl="$git_cmd log --graph --pretty=oneline --abbrev-commit"

unset git_cmd
