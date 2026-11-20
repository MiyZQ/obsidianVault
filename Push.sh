#!/bin/bash
set -euo pipefail

# Change to the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { echo "Failed to enter script directory"; exit 1; }

# Add current directory to Git safe directory list
CURR_PWD="$(pwd)"
if ! git config --global --fixed-value --get-all safe.directory "$CURR_PWD" >/dev/null 2>&1; then
    echo "Configuring safe directory..."
    git config --global --add safe.directory "$CURR_PWD"
fi

echo "Starting snapshot..."
git fetch origin main || true
if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main)" ]; then
    echo "Remote has diverged, abort."; exit 1
fi
git add .

time=$(date +"%Y-%m-%d %H:%M:%S")

# Suppress Git log errors
# Use || true to prevent script exit
count=$(git rev-list --count HEAD 2>/dev/null || echo 0)

if [ "$count" -ge 2 ]; then
    # ---------- rebuild into 2 commits ----------
    old_tree=$(git rev-parse "HEAD^{tree}")
    new_tree=$(git write-tree)

    if [ "$old_tree" = "$new_tree" ]; then
        echo "⏭️ No files modified, skip."
    else
        # Get raw commit object of HEAD^ and filter out all history commits
        raw=$(git cat-file commit HEAD)
        kept=$(printf '%s\n' "$raw" | grep -v '^parent ')
        
        old_commit=$(printf '%s\n' "$kept" | git hash-object -t commit -w --stdin)
        new_commit=$(git commit-tree "$new_tree" -p "$old_commit" -m "Snapshot: $time")

        git reset --hard "$new_commit"
        git push --force-with-lease origin main

        # Git GC
        git reflog expire --expire=now --all
        git gc --prune=now

        echo "✅ Reset to 2-history chain and pushed."
    fi
else
    # ---------- 0 or 1 commits ----------
    if git diff --cached --quiet; then
        echo "⏭️ No changes, skip."
    else
        git commit -m "Snapshot: $time"
        git push --force-with-lease origin main
        echo "✅ Committed and pushed."
    fi
fi

# Print current history
echo ""
echo "==== LOCAL GIT HISTORIES ===="
git log --oneline
if [ -t 0 ]; then read -rsn1 -p "Waiting..."; fi
echo