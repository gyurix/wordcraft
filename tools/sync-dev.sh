#!/usr/bin/env bash
set -euo pipefail
# Auto-sync dev = upstream/main + custom patch branches (re-applied in order).
# Usage: tools/sync-dev.sh [--push] [--dry-run]
PATCHES="linux-window-controls system-theme-detection fix/x11-desktop-dpi"
DRY=0; PUSH=1
for a in "$@"; do case "$a" in --dry-run) DRY=1;; --no-push) PUSH=0;; esac; done
git fetch upstream main
git fetch origin
rm -rf vendor/winit/target
 git checkout -B dev upstream/main
for b in $PATCHES; do
  if git rev-parse --verify "origin/$b" >/dev/null 2>&1; then
    echo "== merging origin/$b =="
    if ! git merge --no-edit "origin/$b"; then
      echo "CONFLICT merging $b — aborting, dev left at $(git rev-parse --short HEAD)"; git merge --abort; exit 1
    fi
  else
    echo "== skip missing origin/$b =="
  fi
done
git diff --check
echo "dev now $(git rev-parse --short HEAD) / $(git log --oneline upstream/main..dev | wc -l) commits ahead"
if [ "$DRY" = 1 ]; then echo "(dry-run, not pushing)"; exit 0; fi
if [ "$PUSH" = 1 ]; then git push origin dev --force-with-lease; fi
