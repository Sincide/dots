#!/usr/bin/env bash
# Parses lm-sensors output for temperatures and fan speeds.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v sensors >/dev/null 2>&1; then
  echo '{"sensors":[]}'
  exit 0
fi

sensors -j || echo '{"sensors":[]}'
