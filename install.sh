#!/usr/bin/env bash
set -e

USER_DIR="${HOME}/Library/Application Support/Sublime Merge/Packages/User"
REPO_URL="https://github.com/itayov/sublime-merge-configurations.git"

# 1. Remove existing preferences (ignore if missing)
rm -f "$USER_DIR/Preferences.sublime-settings"

# 2. Clone or update the configuration repository
if [ -d "$USER_DIR/.git" ]; then
  (cd "$USER_DIR" && git pull)
else
  git clone "$REPO_URL" "$USER_DIR"
fi

# 3. Run the setup script
bash "$USER_DIR/setup.sh"

echo "Sublime Merge configuration ready." >&2
