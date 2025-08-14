#!/usr/bin/env bash
# GPU utilization using nvidia-smi or radeontop.

set -Eeuo pipefail
IFS=$'\n\t'

if command -v nvidia-smi >/dev/null 2>&1; then
  util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  jq -n --argjson util "$util" '{util:util,driver:"nvidia"}'
  exit 0
fi

if command -v radeontop >/dev/null 2>&1; then
  util=$(radeontop -d - -l 1 2>/dev/null | awk -F '[%,]' '/gpu/ {print $2; exit}')
  jq -n --argjson util "$util" '{util:util,driver:"radeon"}'
  exit 0
fi

echo '{"util":0}'
