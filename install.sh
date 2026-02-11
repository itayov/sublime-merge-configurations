#!/usr/bin/env bash
set -euo pipefail

USER_DIR="${HOME}/Library/Application Support/Sublime Merge/Packages/User"
REPO_URL="https://github.com/itayov/sublime-merge-configurations.git"

# 1. Remove existing preferences (ignore if missing)
rm -f "$USER_DIR/Preferences.sublime-settings"

# 2. Clone or update the configuration repository
if [ -d "$USER_DIR/.git" ]; then
  # Avoid `git pull` (can fail on divergent history). Instead, fetch and
  # fast-forward/reset to the remote default branch.
  git -C "$USER_DIR" fetch --prune origin

  # Determine origin's default branch (e.g. "main" / "master").
  ORIGIN_HEAD_REF="$(git -C "$USER_DIR" symbolic-ref -q --short refs/remotes/origin/HEAD || true)"
  if [ -n "$ORIGIN_HEAD_REF" ]; then
    DEFAULT_BRANCH="${ORIGIN_HEAD_REF#origin/}"
  else
    # Fallback if origin/HEAD isn't set for some reason.
    DEFAULT_BRANCH="main"
  fi

  # If the working tree isn't clean, stash so we don't lose local tweaks.
  if ! git -C "$USER_DIR" diff --quiet || ! git -C "$USER_DIR" diff --cached --quiet; then
    git -C "$USER_DIR" stash push -u -m "install.sh backup $(date -u +%Y-%m-%dT%H:%M:%SZ)" >/dev/null
  fi

  # Ensure we're on the default branch, then hard-reset to the remote tip.
  git -C "$USER_DIR" checkout -q "$DEFAULT_BRANCH" 2>/dev/null || git -C "$USER_DIR" checkout -q -B "$DEFAULT_BRANCH"
  git -C "$USER_DIR" reset --hard "origin/$DEFAULT_BRANCH" >/dev/null
else
  git clone "$REPO_URL" "$USER_DIR"
fi

# 3. Run the setup script
bash "$USER_DIR/setup.sh"

echo "Sublime Merge configuration ready." >&2
