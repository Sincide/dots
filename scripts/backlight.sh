#!/usr/bin/env bash
# Backlight brightness control using brightnessctl.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v brightnessctl >/dev/null 2>&1; then
  echo '{"percent":0}'
  exit 0
fi

case ${1:-} in
  --scroll-up)
    brightnessctl set +5%
    exit 0
    ;;
  --scroll-down)
    brightnessctl set 5%-
    exit 0
    ;;
  --help)
    echo 'Usage: backlight.sh [--scroll-up|--scroll-down]'
    exit 0
    ;;
esac

perc=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
jq -n --argjson p "$perc" '{percent:p}'
