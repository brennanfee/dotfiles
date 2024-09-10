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
# END Bash scrict mode

# Aliases to scripts in my dotfiles bin folder

if [[ -x "${DOTFILES}/bin/tmux-current-session" ]]; then
  alias tcs='${DOTFILES}/bin/tmux-current-session'
fi

if [[ -x "${DOTFILES}/bin/tmux-window-switch" ]]; then
  alias tws='${DOTFILES}/bin/tmux-window-switch'
  alias twt='${DOTFILES}/bin/tmux-window-switch t'
  alias twf='${DOTFILES}/bin/tmux-window-switch f'
  alias twl='${DOTFILES}/bin/tmux-window-switch l'
  alias twp='${DOTFILES}/bin/tmux-window-switch p'
  alias twn='${DOTFILES}/bin/tmux-window-switch n'
  alias tw1='${DOTFILES}/bin/tmux-window-switch 1'
  alias tw2='${DOTFILES}/bin/tmux-window-switch 2'
  alias tw3='${DOTFILES}/bin/tmux-window-switch 3'
  alias tw4='${DOTFILES}/bin/tmux-window-switch 4'
  alias tw5='${DOTFILES}/bin/tmux-window-switch 5'
  alias tw6='${DOTFILES}/bin/tmux-window-switch 6'
  alias tw7='${DOTFILES}/bin/tmux-window-switch 7'
  alias tw8='${DOTFILES}/bin/tmux-window-switch 8'
  alias tw9='${DOTFILES}/bin/tmux-window-switch 9'
fi

if [[ -x "${DOTFILES}/bin/do-update" ]]; then
  alias doup='${DOTFILES}/bin/do-update'
fi

if [[ -x "${DOTFILES}/bin/yt-dlp-helper" ]]; then
  alias yt='${DOTFILES}/bin/yt-dlp-helper yt'
  alias ytl='${DOTFILES}/bin/yt-dlp-helper ytl'
  alias ytm='${DOTFILES}/bin/yt-dlp-helper ytm'
  alias ytml='${DOTFILES}/bin/yt-dlp-helper ytml'
  alias ytp='${DOTFILES}/bin/yt-dlp-helper ytp'
  alias ytpl='${DOTFILES}/bin/yt-dlp-helper ytpl'
fi
