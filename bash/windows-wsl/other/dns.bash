#!/usr/bin/env bash

if [[ ! -f /etc/init.d/dns-sync.sh ]]; then
  sudo cp "$DOTFILES/bin/dns-sync.sh" /etc/init.d/dns-sync.sh
fi

if sudo service dns-sync.sh status | grep -q 'dns-sync is not running'; then
  sudo service dns-sync.sh start
fi
