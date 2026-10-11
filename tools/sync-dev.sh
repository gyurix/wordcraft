#!/usr/bin/env bash
set -euo pipefail
# Auto-sync dev = upstream/main + custom patch branches (re-applied in order).
# Usage: tools/sync-dev.sh [--push] [--dry-run] [--no-push]
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
      # Auto-resolve Cargo.lock-only conflicts (stale registry winit vs vendored path):
      # keep new upstream versions, then re-point winit at vendor/.
      if [ "$(git diff --name-only --diff-filter=U | wc -l)" = 1 ] && git diff --name-only --diff-filter=U | grep -qx "Cargo.lock"; then
        echo "auto-resolving Cargo.lock (ours + cargo update -p winit)"
        git checkout --ours Cargo.lock
        cargo update -p winit
        git add Cargo.lock
        git commit --no-edit
      else
        echo "CONFLICT merging $b — aborting"; git merge --abort 2>/dev/null || true; exit 1
      fi
    fi
  else
    echo "== skip missing origin/$b =="
  fi
done
rm -rf vendor/winit/target
# Preserve sync automation (patch branches don't carry it)
git checkout origin/main -- tools/sync-dev.sh .github/workflows/sync-dev.yml .gitignore 2>/dev/null || true
git status --short | grep -q . && git commit -m "chore(dev): preserve sync automation" || true
git diff --check
echo "dev now $(git rev-parse --short HEAD) / $(git log --oneline upstream/main..dev | wc -l) commits ahead"
if [ "$DRY" = 1 ]; then echo "(dry-run, not pushing)"; exit 0; fi
if [ "$PUSH" = 1 ]; then git push origin dev --force-with-lease; fi
