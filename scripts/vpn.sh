#!/usr/bin/env bash
# Checks for active VPN connections via nmcli.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v nmcli >/dev/null 2>&1; then
  echo '{"active":false}'
  exit 0
fi

active=$(nmcli -t -f TYPE,NAME connection show --active | awk -F: '$1=="vpn"{print $2}')
if [[ -n $active ]]; then
  jq -n --arg name "$active" '{active:true,name:$name}'
else
  echo '{"active":false}'
fi
