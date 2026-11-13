#!/bin/bash
set -euo pipefail

# 1. 切换到脚本所在目录（防止路径错乱）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || { echo "❌ 无法进入脚本目录"; exit 1; }

# 2. 把当前目录加入 Git 安全列表（解决所有权警告）
echo "🔒 配置安全目录..."
git config --global --add safe.directory "$(pwd)"

# 3. 初始化仓库（如果已存在也不会报错）
echo "📂 初始化 Git 仓库..."
git init

# 4. 添加所有文件（包括隐藏文件）
echo "📥 添加所有文件到暂存区..."
git add --all

# 5. 提交（如果没有文件会跳过）
echo "💾 提交文件..."
if git commit -m "Initial commit: Add all vault files" 2>&1; then
    echo "✅ 提交成功"
else
    echo "ℹ️ 没有新文件可提交，跳过提交步骤"
fi

# 6. 关联远程仓库（如果已关联则先删除再添加）
echo "🔗 关联远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin https://github.com/MiyZQ/obsidianVault.git

# 7. 重命名分支为 main（兼容旧版 master）
echo "🔀 重命名分支为 main..."
git branch -M main

# 8. 推送到远程仓库
echo "☁️ 推送到远程仓库..."
git push -u origin main

read -rsn1 -p "\n🎉 全部操作完成！请去 GitHub 仓库检查文件是否同步成功。"
echo