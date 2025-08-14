#!/usr/bin/env bash
# Microphone mute toggle using wpctl.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v wpctl >/dev/null 2>&1; then
  echo '{"muted":true}'
  exit 0
fi

case ${1:-} in
  --toggle)
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    exit 0
    ;;
  --help)
    echo 'Usage: mic.sh [--toggle]'
    exit 0
    ;;
esac

state=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
muted=false
[[ $state == *MUTED* ]] && muted=true
jq -n --argjson muted "$muted" '{muted:muted}'
