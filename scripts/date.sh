#!/usr/bin/env bash
# Date/time module with optional calendar JSON.

set -Eeuo pipefail
IFS=$'\n\t'

case ${1:-} in
  --calendar)
    cal --iso | awk '{print NR ":" $0}' | jq -R -s 'split("\n")'
    exit 0
    ;;
  --help)
    echo 'Usage: date.sh [--calendar]'
    exit 0
    ;;
esac

iso=$(date --iso-8601=seconds)
jq -n --arg iso "$iso" '{iso:$iso}'
