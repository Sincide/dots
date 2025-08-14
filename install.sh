#!/usr/bin/env bash
# Idempotent installer for the Quickshell setup.

set -Eeuo pipefail
IFS=$'\n\t'

if [[ $EUID -eq 0 ]]; then
  echo 'Run as regular user with sudo privileges.'
  exit 1
fi

source /etc/os-release
if [[ $ID != 'arch' ]]; then
  echo 'This installer targets Arch Linux.'
  exit 1
fi

PKGS=(quickshell swaync hyprland niri wl-clipboard cliphist playerctl brightnessctl upower powerprofilesctl lm_sensors jq networkmanager bluez bluez-utils grim slurp satty fuzzel wlogout fastfetch fzf kitty radeontop)

echo '[install] Installing packages via yay'
if ! command -v yay >/dev/null 2>&1; then
  echo 'yay AUR helper not found. Install it first.'
  exit 1
fi
yay -S --needed --noconfirm "${PKGS[@]}"

echo '[install] Linking configuration with stow'
./scripts/stow.sh

systemctl --user daemon-reload
systemctl --user enable --now quickshell.service swaync.service

# Probe sensors quietly
sensors >/dev/null 2>&1 || true

./scripts/check-deps.sh || true

echo 'Installation complete. Relog or restart the compositor.'
