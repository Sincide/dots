#!/usr/bin/env bash
# Handles volume information and interactions via wpctl (PipeWire).

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v wpctl >/dev/null 2>&1; then
  echo '{"volume":0,"muted":true}'
  exit 0
fi

case ${1:-} in
  --click)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    exit 0
    ;;
  --scroll-up)
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+
    exit 0
    ;;
  --scroll-down)
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-
    exit 0
    ;;
  --middle)
    command -v pavucontrol >/dev/null 2>&1 && pavucontrol &
    exit 0
    ;;
  --help)
    echo 'Usage: audio.sh [--click|--scroll-up|--scroll-down|--middle]'
    exit 0
    ;;
esac

line=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
vol=$(awk '{print int($2*100)}' <<<"$line")
muted=false
[[ $line == *MUTED* ]] && muted=true
jq -n --argjson vol "$vol" --argjson muted "$muted" '{volume:vol,muted:muted}'
