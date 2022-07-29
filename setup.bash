#!/usr/bin/env bash
# setup.bash - Script to set up a new machine with my dotfiles.

# Bash strict mode
([[ -n ${ZSH_EVAL_CONTEXT:-} && ${ZSH_EVAL_CONTEXT:-} =~ :file$ ]] ||
 [[ -n ${BASH_VERSION:-} ]] && (return 0 2>/dev/null)) && SOURCED=true || SOURCED=false
if ! ${SOURCED}
then
  set -o errexit # same as set -e
  set -o nounset # same as set -u
  set -o errtrace # same as set -E
  set -o pipefail
  set -o posix
  #set -o xtrace # same as set -x, turn on for debugging

  shopt -s inherit_errexit
  shopt -s extdebug
  IFS=$(printf '\n\t')
fi
# END Bash scrict mode

# Current directory
dotfiles="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=/home/brennan/.dotfiles/bash/base-profile.bash
source "${dotfiles}/bash/base-profile.bash"

# At this point, the machine may not be fully set up and as a result we can't rely on
# the bash environment being setup either.  So we can't use xdg-user-dir or expect the
# environment variables to be there.  These are where I should be putting my dotfiles
# paths anyway, so hard code them here.
dotfiles=${dotfiles:-${HOME}/.dotfiles}
dotfiles_private=${dotfiles_private:-${HOME}/.dotfiles-private}

echo ""
echo -e "${text_green}Starting setup...${text_normal}"
echo ""

if ! command -v "rcup" &>/dev/null; then
  echo -e "${text_red}RCM is not installed.  Please install it and try again.${text_normal}"
  exit 1
fi

if ! command -v "curl" &>/dev/null; then
  echo -e "${text_red}Curl is not installed.  Please install it and try again.${text_normal}"
  exit 1
fi

rcup -f -K -d "${dotfiles}/rcs" -d "${dotfiles_private}/rcs" rcrc

if [[ -f "${HOME}/.rcrc" ]]; then
  echo -e "${text_yellow}Home .rcrc is in place.${text_normal}"
  echo ""
else
  echo -e "${text_white}Creating new ~/.rcrc file.${text_normal}"
  echo ""
  cp "${dotfiles}/base-rcrc" "${HOME}/.rcrc"

  if [[ ${OS_PRIMARY} == "linux" ]]; then
    echo "TAGS=\"${OS_PRIMARY} ${OS_SECONDARY} home\"" >>"${HOME}/.rcrc"
  else
    echo "TAGS=\"${OS_PRIMARY} home\"" >>"${HOME}/.rcrc"
  fi

  echo -e "${text_yellow}~/.rcrc file created.  You will need to add it with mkrc -o ~/.rcrc${text_normal}"
fi

echo -e "${text_green}Done!  Edit the ~/.rcrc as needed then run 'rcup'${text_normal}"
echo ""

unset dotfiles
unset dotfiles_private
