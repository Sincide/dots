#!/usr/bin/env bash
# Check pacman and AUR updates using checkupdates and yay.

set -Eeuo pipefail
IFS=$'\n\t'

pac=0
if command -v checkupdates >/dev/null 2>&1; then
  pac=$(checkupdates 2>/dev/null | wc -l)
fi

aur=0
if command -v yay >/dev/null 2>&1; then
  aur=$(yay -Qua 2>/dev/null | wc -l)
fi

total=$((pac+aur))
jq -n --argjson pac "$pac" --argjson aur "$aur" --argjson total "$total" '{pac:pac,aur:aur,total:total}'
