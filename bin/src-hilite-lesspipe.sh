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

for source in "$@"; do
    case ${source} in
	*ChangeLog|*changelog)
        source-highlight --failsafe -f esc256 --lang-def=changelog.lang --style-file=esc256.style -i "${source}" ;;
	*Makefile|*makefile)
        source-highlight --failsafe -f esc256 --lang-def=makefile.lang --style-file=esc256.style -i "${source}" ;;
	*.tar|*.tgz|*.gz|*.bz2|*.xz)
        lesspipe "${source}" ;;
        *) source-highlight --failsafe --infer-lang -f esc256 --style-file=esc256.style -i "${source}" ;;
    esac
done
