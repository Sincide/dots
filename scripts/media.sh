#!/usr/bin/env bash
# Playerctl wrapper for media player info and control.

set -Eeuo pipefail
IFS=$'\n\t'

if ! command -v playerctl >/dev/null 2>&1; then
  echo '{"playing":false}'
  exit 0
fi

case ${1:-} in
  --next)
    playerctl next
    exit 0
    ;;
  --prev)
    playerctl previous
    exit 0
    ;;
  --play-pause)
    playerctl play-pause
    exit 0
    ;;
  --help)
    echo 'Usage: media.sh [--next|--prev|--play-pause]'
    exit 0
    ;;
esac

meta=$(playerctl metadata --format '{{status}}|{{artist}}|{{title}}')
status=${meta%%|*}
artist=${meta#*|}; artist=${artist%%|*}
title=${meta##*|}
jq -n --arg status "$status" --arg artist "$artist" --arg title "$title" '{status:$status,artist:$artist,title:$title}'
