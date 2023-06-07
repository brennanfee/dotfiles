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

function _write_msg() {
  local bold
  local reset
  local green
  local t_cols
  t_cols=$(tput cols)
  t_cols=$((t_cols - 1))
  reset="$(tput sgr0)"
  bold="$(tput bold)"
  green="$(tput setaf 2)"
  echo -e "${bold}${green}$1${reset}" | fold -sw "${t_cols}"
}

function doUpdate() {
  local toUpdate="${1:-all}"

  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "apt" ]]; then
    if command_exists apt-get; then
      _write_msg "Getting updates with apt"
      DEBIAN_FRONTEND=noninteractive sudo apt-get -y -q update
      DEBIAN_FRONTEND=noninteractive sudo apt-get -y -q full-upgrade
      DEBIAN_FRONTEND=noninteractive sudo apt-get -y -q autoremove
    fi
  fi

  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "flatpak" ]]; then
    if command_exists flatpak; then
      _write_msg "Getting updates with flatpak"
      flatpak upgrade -y --noninteractive --system
      flatpak upgrade -y --noninteractive --user
    fi
  fi

  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "snap" ]]; then
    if command_exists snap; then
      _write_msg "Getting updates with snap"
      sudo snap refresh
    fi
  fi

  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "pipx" ]]; then
    if command_exists pipx; then
      _write_msg "Getting updates with pipx"
      pipx upgrade-all
    fi
  fi

  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "asdf" ]]; then
    if command_exists asdf; then
      _write_msg "Updating asdf"
      asdf update
      _write_msg "Updating plugins for asdf"
      asdf plugin update --all
    fi
  fi

  # Tmux Updates
  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "tmux" ]]; then
    if command_exists tmux; then
      _write_msg "Updating tmux plugins"
      TMUX_PLUGIN_MANAGER_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins"

      # Download the tmux plugin manager if it isn't already there
      if [[ ! -d "${TMUX_PLUGIN_MANAGER_PATH}/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm "${TMUX_PLUGIN_MANAGER_PATH}/tpm"
      fi

      if [[ -f "${TMUX_PLUGIN_MANAGER_PATH}/tpm/bin/install_plugins" ]]; then
        "${TMUX_PLUGIN_MANAGER_PATH}/tpm/bin/install_plugins"
      fi
    fi
  fi

  # Vim Updates
  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "vim" ]]; then
    if command_exists vim; then
      _write_msg "Updating vim plugins"
      mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/vim"
      mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

      # Download vim-plug & initialize the bundles if needed
      if [[ ! -e ${HOME}/.vim/autoload/plug.vim ]]; then
        curl -fsSLo "${HOME}/.vim/autoload/plug.vim" --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      fi

      if [[ -f ${HOME}/.vim/vimrc.bundles ]]; then
        /usr/bin/vim -N -u "${HOME}/.vim/vimrc.bundles" +PlugUpdate +PlugClean! +qa!
      fi

      # Create the scratch directories
      mkdir -p "${HOME}/.vim/vimscratch/backup"
      mkdir -p "${HOME}/.vim/vimscratch/swap"
      mkdir -p "${HOME}/.vim/vimscratch/undo"
    fi
  fi

  # Neovim Updates
  if [[ "${toUpdate}" == "all" || "${toUpdate}" == "nvim" || "${toUpdate}" == "neovim" ]]; then
    if command_exists nvim; then
      _write_msg "Updating nvim plugins"
      nvim --headless "+Lazy! sync" +qa!
    fi
  fi

  # Record last update
  date +"%Y-%m-%d %r" >> "${XDG_CACHE_HOME:-$HOME/.cache}/updates.log"
}

alias doup=doUpdate
