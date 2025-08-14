#!/usr/bin/env bash
# Prints the active window title for the current compositor.

set -Eeuo pipefail
IFS=$'\n\t'

WM=$(scripts/wm-detect.sh 2>/dev/null || true)
case $WM in
  hyprland)
    hyprctl activewindow -j | jq -r '.title // ""'
    ;;
  niri)
    niri msg -j active-window | jq -r '.title // ""'
    ;;
  *)
    echo ''
    ;;
esac
