#!/usr/bin/env bash
# Bluetooth status via bluetoothctl.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v bluetoothctl >/dev/null 2>&1; then
  echo '{"powered":false}'
  exit 0
fi

power=$(bluetoothctl show | awk -F: '/Powered/ {gsub(/ /,"",$2);print tolower($2)}')
active=$(bluetoothctl info 2>/dev/null | awk -F: '/Device/ {print $2;exit}')

jq -n --arg power "$power" --arg device "$active" '{powered:($power=="yes"),device:$device}'
