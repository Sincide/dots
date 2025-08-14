cat <<'EOF' > scripts/stow.sh
#!/usr/bin/env bash
# Wrapper around GNU Stow to manage symlinks for this dotfiles repo.
# It enables both stow and unstow operations with sane defaults.

set -Eeuo pipefail
IFS=$'\n\t'

usage() {
  cat <<USAGE
Usage: stow.sh [--unstow] [TARGET...]

Invokes GNU Stow from the repository root to manage symlinks under \$HOME.
If no TARGET is provided, stows all top-level directories that look like
config segments (prefixed with a dot or known names).

Examples:
  scripts/stow.sh             # stow everything
  scripts/stow.sh hypr fish   # stow only selected dirs
  scripts/stow.sh --unstow    # remove all symlinks
USAGE
}

unstow=false
if [[ ${1:-} == "--help" ]]; then
  usage
  exit 0
fi
if [[ ${1:-} == "--unstow" ]]; then
  unstow=true
  shift
fi

dirs=("$@")
if [[ ${#dirs[@]} -eq 0 ]]; then
  mapfile -t dirs < <(find . -maxdepth 1 -type d ! -name '.git' ! -name 'scripts' ! -name 'assets' -printf '%P\n')
fi

cmd=(stow --target "$HOME" --verbose)
$unstow && cmd+=(--delete)

for d in "${dirs[@]}"; do
  [[ -d $d ]] || continue
  echo "[stow] processing $d"
  stow_cmd=("${cmd[@]}" "$d")
  if ! command -v stow >/dev/null 2>&1; then
    echo "GNU stow not found; skipping"
    break
  fi
  "${stow_cmd[@]}"
done
