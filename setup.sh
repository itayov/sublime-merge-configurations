#!/usr/bin/env bash
set -e

git config --global alias.sir '!sh -c "git rebase -i `git merge-base HEAD $1` --autosquash"' || true

echo "Added alias 'sir' to git" >&2
