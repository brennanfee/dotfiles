#!/usr/bin/env bash

# Set bash to vi line edit mode
set -o vi

# Don't use ^D to exit
set -o ignoreeof

# Don't wait for job termination notification
set -o notify

# Don't allow redirection to overwrite existing files
set -o noclobber

### Globbing ###
# Turn on extended globbing
shopt -s extglob
# Resolve filenames that start with . for globbing
shopt -s dotglob
# Use case-insensitive filename globbing
shopt -s nocaseglob
# Turn on globstar **
shopt -s globstar

### History ###
# Make bash append rather than overwrite the history on disk
shopt -s histappend

# Show a history substituion line rather than directly executing it
shopt -s histverify

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# Treat arguments to the cd-command as a variable name containing a directory to cd into.
shopt -s cdable_vars

# Check the window size after each command and update LINES/COLUMNS
shopt -s checkwinsize

# Store multi-line commands in a single history entry
shopt -s cmdhist

# Turn off shell mail handling
shopt -u mailwarn
