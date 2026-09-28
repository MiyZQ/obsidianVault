#!/bin/bash
set -euo pipefail

# 1. 切换到脚本所在目录（防止路径错乱）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { echo "❌ 无法进入脚本目录"; exit 1; }

# 2. 把当前目录加入 Git 安全列表（解决所有权警告）
echo "🔐 配置安全目录..."
git config --global --add safe.directory "$(pwd)"

# 3. 开始同步与快照
echo "🚀 开始执行快照..."
git fetch origin main || true
git add .

time=$(date +"%Y-%m-%d %H:%M:%S")
# 捕获 git log 报错（例如未有任何提交时），用 || true 保证脚本不中断
count=$(git log --oneline 2>/dev/null | wc -l | tr -d ' ' || true)

if [ "$count" -ge 2 ]; then
    # ---------- 已有 >= 2 条：重建为“孤儿旧提交 + 新快照”两条 ----------
    old_tree=$(git rev-parse "HEAD^{tree}")
    new_tree=$(git write-tree)

    if [ "$old_tree" = "$new_tree" ]; then
        echo "⏭️ 内容与当前快照一致，跳过本次提交。"
    else
        # 取 HEAD^ 的原始 commit 对象，过滤掉所有 parent 行（使其成为孤儿提交）
        raw=$(git cat-file commit HEAD)
        kept=$(printf '%s\n' "$raw" | grep -v '^parent ')
        new_raw=$(printf '%s\n' "$kept")
        
        old_commit=$(printf '%s\n' "$new_raw" | git hash-object -t commit -w --stdin)

        # 新快照，父 = 孤儿提交
        new_commit=$(git commit-tree "$new_tree" -p "$old_commit" -m "Snapshot: $time")

        git reset --hard "$new_commit"
        git push --force-with-lease origin main

        # 彻底清掉旧对象
        git reflog expire --expire=now --all
        git gc --prune=now
        echo "✅ 已重置为两条历史并推送。"
    fi
else
    # ---------- 0 或 1 条：正常提交 ----------
    if git diff --cached --quiet; then
        echo "⏭️ 没有改动，跳过本次提交。"
    else
        git commit -m "Snapshot: $time"
        git push --force-with-lease origin main
        echo "✅ 已提交并推送。"
    fi
fi

# 4. 打印当前历史
echo ""
echo "==== LOCAL GIT HISTORIES ===="
git log --oneline
read -rsn1 -p "Wait..."
echo