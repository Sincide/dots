#!/usr/bin/env bash
# Detects running Wayland compositor: hyprland or niri.
# Sets WM environment variable accordingly.

set -Eeuo pipefail
IFS=$'\n\t'

wm=""
if pgrep -x hyprland >/dev/null 2>&1; then
  wm=hyprland
elif pgrep -x niri >/dev/null 2>&1; then
  wm=niri
fi

if [[ -n $wm ]]; then
  printf '%s\n' "$wm"
else
  echo 'unknown'
  exit 1
fi
