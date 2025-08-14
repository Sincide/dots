#!/usr/bin/env bash
# Outputs workspace information in JSON for either Hyprland or Niri.

set -Eeuo pipefail
IFS=$'\n\t'

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
WM=$("$SCRIPT_DIR"/wm-detect.sh 2>/dev/null || true)
case $WM in
  hyprland)
    if command -v hyprctl >/dev/null 2>&1; then
      hyprctl -j workspaces
      exit 0
    fi
    ;;
  niri)
    if command -v niri >/dev/null 2>&1; then
      niri msg -j workspaces
      exit 0
    fi
    ;;
 esac

# Fallback empty result
echo '[]'
