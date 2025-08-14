#!/usr/bin/env bash
# Removes symlinks and systemd units created by install.sh.

set -Eeuo pipefail
IFS=$'\n\t'

systemctl --user disable --now quickshell.service swaync.service 2>/dev/null || true

./scripts/stow.sh --unstow

if [[ ${1:-} == '--remove' ]]; then
  PKGS=(quickshell swaync)
  yay -Rns "${PKGS[@]}"
fi

echo 'Uninstall complete.'
