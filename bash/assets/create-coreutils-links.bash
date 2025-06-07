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

function load_script_tools() {
  local dotfiles
  dotfiles="${DOTFILES:-$(xdg-user-dir DOTFILES)}"
  # Source script-tools.bash
  if [[ -f "${dotfiles}/bash/script-tools.bash" ]]; then
    # shellcheck source=/home/brennan/.dotfiles-rc/bash/script-tools.bash
    source "${dotfiles}/bash/script-tools.bash"
  fi
}

function link_coreutils() {
  local bin="coreutils"
  if command_exists "${bin}"; then
    local tool_path link_path
    tool_path="$(which "${bin}")"
    link_path="$(xdg-user-dir BIN)/${bin}"

    # echo "tool path: ${tool_path}"
    # echo "link path: ${link_path}"

    /usr/bin/mkdir -p "${link_path}"
    /usr/bin/rm -f "${link_path}"/*

    ## Create links for each tool
    /usr/bin/ln -sf "${tool_path}" "${link_path}/arch"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/b2sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/b3sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/base32"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/base64"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/basename"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/basenc"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/cat"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/chcon"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/chgrp"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/chmod"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/chown"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/chroot"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/cksum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/comm"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/cp"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/csplit"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/cut"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/date"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/dd"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/df"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/dircolors"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/dirname"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/du"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/echo"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/env"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/expand"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/expr"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/factor"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/false"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/fmt"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/fold"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/groups"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/hashsum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/head"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/hostid"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/hostname"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/id"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/install"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/join"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/kill"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/link"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/ln"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/logname"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/ls"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/md5sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/mkdir"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/mkfifo"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/mknod"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/mktemp"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/more"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/mv"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/nice"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/nl"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/nohup"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/nproc"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/numfmt"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/od"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/paste"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/pathchk"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/pinky"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/pr"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/printenv"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/printf"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/ptx"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/pwd"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/readlink"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/realpath"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/rm"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/rmdir"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/runcon"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/seq"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha1sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha3sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha3-224sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha3-256sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha3-384sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha3-512sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha224sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha256sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha384sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sha512sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/shake128sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/shake256sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/shred"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/shuf"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sleep"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sort"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/split"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/stat"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/stdbuf"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/stty"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sum"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sync"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/tac"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/tail"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/tee"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/test"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/timeout"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/touch"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/tr"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/true"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/truncate"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/tsort"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/tty"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/uname"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/unexpand"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/uniq"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/unlink"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/uptime"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/users"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/vdir"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/wc"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/who"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/whoami"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/yes"
  fi
}

function link_diffutils() {
  local bin="diffutils"
  if command_exists "${bin}"; then
    local tool_path link_path
    tool_path="$(which "${bin}")"
    link_path="$(xdg-user-dir BIN)/${bin}"

    # echo "tool path: ${tool_path}"
    # echo "link path: ${link_path}"

    /usr/bin/mkdir -p "${link_path}"
    /usr/bin/rm -f "${link_path}"/*

    ## Create links for each tool
    /usr/bin/ln -sf "${tool_path}" "${link_path}/cmp"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/diff"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/diff3"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/sdiff"
  fi
}

function link_findutils() {
  local bin="findutils"
  if command_exists "${bin}"; then
    local tool_path link_path
    tool_path="$(which "${bin}")"
    link_path="$(xdg-user-dir BIN)/${bin}"

    # echo "tool path: ${tool_path}"
    # echo "link path: ${link_path}"

    /usr/bin/mkdir -p "${link_path}"
    /usr/bin/rm -f "${link_path}"/*

    ## Create links for each tool
    /usr/bin/ln -sf "${tool_path}" "${link_path}/find"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/locate"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/updatedb"
    /usr/bin/ln -sf "${tool_path}" "${link_path}/xargs"
  fi
}

function main() {
  load_script_tools

  link_coreutils
  link_diffutils
  link_findutils
}

main "$@"
