#!/usr/bin/env bash
# Emits sample JSON payloads for modules. Useful for theming without hardware access.

set -Eeuo pipefail
IFS=$'\n\t'

usage() {
  cat <<USAGE
Usage: simulate.sh MODULE
Available MODULE values: cpu net audio battery date
USAGE
}

module=${1:-}
if [[ -z $module || $module == '--help' ]]; then
  usage
  exit 0
fi

case $module in
  cpu)
    printf '{"usage":42,"temp":55}'
    ;;
  net)
    printf '{"interface":"wlan0","down":1000,"up":200}'
    ;;
  audio)
    printf '{"volume":73,"muted":false}'
    ;;
  battery)
    printf '{"percent":88,"status":"Discharging"}'
    ;;
  date)
    printf '{"iso":"2024-01-01T12:00:00"}'
    ;;
  *)
    echo "Unknown module $module" >&2
    exit 1
    ;;
esac
printf '\n'
