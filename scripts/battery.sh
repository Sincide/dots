#!/usr/bin/env bash
# Battery status using upower.

set -Eeuo pipefail
IFS=$'\n\t'

device=$(upower -e 2>/dev/null | grep -m1 battery || true)
if [[ -z $device ]]; then
  echo '{"present":false}'
  exit 0
fi

percent=$(upower -i "$device" | awk '/percentage/ {gsub(/%/,"",$2);print $2}')
status=$(upower -i "$device" | awk -F: '/state/ {gsub(/ /,"",$2);print $2}')
time=$(upower -i "$device" | awk -F: '/time to/ {gsub(/^[ ]+/,"",$2);print $2}' | head -n1)

jq -n --argjson p "$percent" --arg s "$status" --arg t "$time" '{percent:p,status:s,time:t}'
