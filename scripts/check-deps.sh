#!/usr/bin/env bash
# Verifies presence of runtime dependencies required by the Quickshell setup.
# Used during installation and CI checks.

set -Eeuo pipefail
IFS=$'\n\t'

# List of commands to check; extend as modules require.
DEPS=(
  quickshell
  swaync
  hyprctl
  niri
  wpctl
  nmcli
  bluetoothctl
  playerctl
  brightnessctl
  upower
  powerprofilesctl
  sensors
  jq
  cliphist
  wl-paste
  wl-copy
  grim
  slurp
  satty
)

missing=()
for cmd in "${DEPS[@]}"; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing+=("$cmd")
  fi
done

if (( ${#missing[@]} > 0 )); then
  printf 'Missing dependencies: %s\n' "${missing[*]}" >&2
  exit 1
fi

printf 'All dependencies satisfied.\n'
