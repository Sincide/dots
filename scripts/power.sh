#!/usr/bin/env bash
# Power profile status using powerprofilesctl.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v powerprofilesctl >/dev/null 2>&1; then
  echo '{"profile":"unknown"}'
  exit 0
fi

case ${1:-} in
  --next)
    cur=$(powerprofilesctl get)
    if [[ $cur == 'performance' ]]; then
      powerprofilesctl set balanced
    else
      powerprofilesctl set performance
    fi
    exit 0
    ;;
  --help)
    echo 'Usage: power.sh [--next]'
    exit 0
    ;;
esac

profile=$(powerprofilesctl get)
jq -n --arg profile "$profile" '{profile:$profile}'
