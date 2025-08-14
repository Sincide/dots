#!/usr/bin/env bash
# Clipboard helper using wl-clipboard and cliphist.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v cliphist >/dev/null 2>&1; then
  echo '{"size":0}'
  exit 0
fi

case ${1:-} in
  --copy)
    wl-copy < "${2:-}"
    exit 0
    ;;
  --paste)
    cliphist list | fzf | wl-copy && wl-paste
    exit 0
    ;;
  --clear)
    cliphist wipe
    exit 0
    ;;
  --help)
    echo 'Usage: clipboard.sh [--copy FILE|--paste|--clear]'
    exit 0
    ;;
esac

size=$(cliphist list | wc -l)
jq -n --argjson s "$size" '{size:s}'
