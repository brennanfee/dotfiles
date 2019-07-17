#!/usr/bin/env bash

function doUpdate() {
  if [[ "$OS_SECONDARY" == "ubuntu" || "$OS_SECONDARY" == "debian" ]]; then
    sudo apt-get update && sudo apt-get full-upgrade -y && sudo apt-get autoremove -y
  else
    echo "Unable to determine os or distribution."
  fi
}
