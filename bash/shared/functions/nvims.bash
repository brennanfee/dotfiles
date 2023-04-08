#!/usr/bin/env bash

# Bash strict mode
# shellcheck disable=SC2154
([[ -n ${ZSH_EVAL_CONTEXT} && ${ZSH_EVAL_CONTEXT} =~ :file$ ]] ||
 [[ -n ${BASH_VERSION} ]] && (return 0 2>/dev/null)) && SOURCED=true || SOURCED=false
if ! ${SOURCED}; then
  set -o errexit # same as set -e
  set -o nounset # same as set -u
  set -o errtrace # same as set -E
  set -o pipefail
  set -o posix
  #set -o xtrace # same as set -x, turn on for debugging

  shopt -s extdebug
  IFS=$(printf '\n\t')
fi
# END Bash scrict mode

# NeoVim config switcher - This utility allows me to select different Nvim configurations.  Note that this only works with NVim version 0.9.0 and above as it uses the new NVIM_APPNAME feature.

if ! command_exists fzf
then
  return 0
fi

alias nvim-default="nvim"
alias nvim-blank="NVIM_APPNAME=nvim-blank nvim"
alias nvim-astro="NVIM_APPNAME=nvim-AstroVim nvim"
alias nvim-chad="NVIM_APPNAME=nvim-NvChad nvim"
alias nvim-kick="NVIM_APPNAME=nvim-Kickstart nvim" # Kickstart
alias nvim-lazy="NVIM_APPNAME=nvim-LazyVim nvim"
alias nvim-lunar="NVIM_APPNAME=nvim-LunarVim nvim"
alias nvim-space="NVIM_APPNAME=nvim-SpaceVim nvim"

function nvims() {
  items=("default" "blank" "AstroVim" "NvChad" "Kickstart" "LazyVim" "LunarVim" "SpaceVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=50 --layout=reverse --border --exit-0)
  if [[ -z ${config} ]]
  then
    echo "Nothing selected"
    return 0
  elif [[ ${config} == "default" ]]
  then
    nvim "$@"
  else
    NVIM_APPNAME="nvim-${config}" nvim "$@"
  fi
}

#bindkey -s ^n "nvims\n" # zsh binding
bind -x '"\C-n": nvims'
