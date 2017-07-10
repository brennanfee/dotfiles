#!/usr/bin/env bash
# Bash "strict" mode
set -euo pipefail
IFS=$'\n\t'

# initialize-settings.sh - Script to set up a new machine with my dotfiles.

DOTFILES="$(dirname $(realpath $BASH_SOURCE))"

source "$DOTFILES/bash/base-colors.bash"
source "$DOTFILES/bash/base-functions.bash"

SetOsEnvironmentVariables

echo ""
echo -e "${green}Starting setup...${normal}"
echo ""

if ! command_exists rcup; then
    echo -e "${red}RCM is not installed.  Please install it and try again.${normal}"
    exit 1
fi

if ! command_exists curl; then
    echo -e "${red}Curl is not installed.  Please install it and try again.${normal}"
    exit 1
fi

rcup -f -K -d "$HOME/.dotfiles/rcs" -d "$HOME/.dotfiles-private/rcs" rcrc

if [[ -f "$HOME/.rcrc" ]]; then
    echo -e "${yellow}Home .rcrc is in place.${normal}"
    echo ""
else
    echo -e "${white}Creating new ~/.rcrc file.${normal}"
    echo ""
    cp "$DOTFILES/base-rcrc" "$HOME/.rcrc"

    if [[ $OS_PRIMARY == "linux" ]]; then
        echo "TAGS=\"$OS_PRIMARY $OS_SECONDARY\"" >> "$HOME/.rcrc"
    else
        echo "TAGS=\"$OS_PRIMARY\"" >> "$HOME/.rcrc"
    fi

    mkrc -o "$HOME/.rcrc"
fi

echo -e "${green}Done!  Edit the ~/.rcrc as needed then run 'rcup'${normal}"
echo ""

unset DOTFILES
