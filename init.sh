#!/bin/bash
set -euo pipefail

REMOTE_URL="${1:https://github.com/MiyZQ/obsidianVault.git}"

# Change to the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { echo "Failed to enter script directory"; exit 1; }

# Add current directory to Git safe directory list
CURR_PWD="$(pwd)"
if ! git config --global --fixed-value --get-all safe.directory "$CURR_PWD" >/dev/null 2>&1; then
    echo "Configuring safe directory..."
    git config --global --add safe.directory "$CURR_PWD"
fi

echo "Initializing Git repository..."
git init

echo "Staging all files..."
git add --all

echo "Committing files..."
if git commit -m "Initial commit: Add all vault files" 2>&1; then
    echo "✅ Commit succeeded."
else
    echo "⏭️ No new changes to commit, skip."
fi

# Link remote repository
echo "Linking remote repository..."
git remote remove origin 2>/dev/null || true
git remote add origin "${REMOTE_URL}"

echo "Renaming branch to main..."
git branch -M main

echo "Pushing to remote repository..."
git push -u origin main

if [ -t 0 ]; then read -rsn1 -p "All tasks finished. Waiting..."; fi
echo 