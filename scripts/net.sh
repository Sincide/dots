#!/usr/bin/env bash
# Reports current network connection status via nmcli.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v nmcli >/dev/null 2>&1; then
  echo '{"connected":false}'
  exit 0
fi

type=$(nmcli -t -f TYPE,STATE connection show --active | head -n1)
iface=$(nmcli -t -f DEVICE,STATE device status | awk -F: '$2=="connected"{print $1;exit}')
ip=$(nmcli -t -f IP4.ADDRESS device show "$iface" 2>/dev/null | head -n1 | cut -d= -f2)

jq -n --arg type "$type" --arg iface "$iface" --arg ip "$ip" '{type:$type,iface:$iface,ip:$ip}'
