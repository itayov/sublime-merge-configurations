Based on the image provided, here is the extracted text formatted in Markdown:

# Sublime Merge Configurations

Configuration files for a better use of Sublime Merge git client

## How to setup

1. Install Sublime Merge
2. Run in shell (one line, no copy-paste issues):

```bash
curl -sL https://raw.githubusercontent.com/itayov/sublime-merge-configurations/main/install.sh | bash
```

Or run the steps manually:

```bash
USER_DIR="$HOME/Library/Application Support/Sublime Merge/Packages/User"
REPO_URL="https://github.com/itayov/sublime-merge-configurations.git"
rm -f "$USER_DIR/Preferences.sublime-settings"
if [ -d "$USER_DIR/.git" ]; then (cd "$USER_DIR" && git pull); else git clone "$REPO_URL" "$USER_DIR"; fi
bash "$USER_DIR/setup.sh"
```



