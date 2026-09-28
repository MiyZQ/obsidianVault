# 版本控制与 Git | Missing Semester

## 目录

1. [什么是版本控制系统](第五讲_版本控制与Git.md#1-什么是版本控制系统)
2. [为什么需要版本控制](第五讲_版本控制与Git.md#2-为什么需要版本控制)
3. [Git 的数据模型](第五讲_版本控制与Git.md#3-git-的数据模型)
4. [对象与引用](第五讲_版本控制与Git.md#4-对象与引用)
5. [暂存区 (Staging Area)](第五讲_版本控制与Git.md#5-暂存区-staging-area)
6. [基础命令实战](第五讲_版本控制与Git.md#6-基础命令实战)
7. [分支操作](第五讲_版本控制与Git.md#7-分支操作)
8. [合并 (Merge)](第五讲_版本控制与Git.md#8-合并-merge)
9. [远程仓库与协作](第五讲_版本控制与Git.md#9-远程仓库与协作)
10. [其他常用命令](第五讲_版本控制与Git.md#10-其他常用命令)
11. [总结与学习资源](第五讲_版本控制与Git.md#11-总结与学习资源)

---

## 1. 什么是版本控制系统

**版本控制系统 (Version Control System, VCS)** 是一种用于追踪文件（尤其是源代码）变化的软件工具。

### 核心功能

- **追踪历史**：记录代码库每个版本的完整状态
- **维护元数据**：记录谁创建了快照、何时创建、以及变更说明
- **支持协作**：方便多人协同开发

### 快照模型

Git 将工作目录在某个时间点的状态建模为一系列**快照 (Snapshot)**。每个快照包含：
- 整个目录的完整文件内容
- 文件夹结构
- 相关的元数据

---

## 2. 为什么需要版本控制

### 单独开发场景

- **查看旧版本**：随时回溯项目历史
- **并行开发**：同时开发多个功能，互不干扰
- **修复 bug**：创建专门分支修复问题，不影响主开发线

### 团队协作场景

- 避免"来回发送压缩包"这种混乱的协作方式
- 多人可以同时修改同一代码库
- 清晰地追踪每个人的贡献

### 高级功能

- **代码溯源**：`git blame` 可以查看某行代码的最后修改者和时间
- **Bug 定位**：使用 `git bisect` 自动二分搜索版本历史，定位引入 bug 的提交
- **分支工作流**：支持复杂的开发流程（如 GitFlow）

---

## 3. Git 的数据模型

### 核心概念

| Git 术语 | 含义 |
|---------|------|
| **Blob** | 文件内容（binary large object） |
| **Tree** | 目录/文件夹 |
| **Commit** | 快照节点，包含元数据 |
| **Snapshot** | 某时刻项目的完整状态（对应一个顶层 Tree） |

### 数据结构的伪代码表示

```python
# Blob: 文件内容
# 只是一个字节数组
type blob = array<byte>

# Tree: 目录结构
# 映射名称到内容（可以是 blob 或 tree）
type tree = map<string, tree | blob>

# Commit: 提交记录
# 包含快照、父子提交、作者、消息等
type commit = struct {
    parent: array<commit>
    snapshot: tree
    message: string
    author: string
}
```

### 有向无环图 (DAG)

Git 的历史不是简单的线性序列，而是一个**有向无环图 (Directed Acyclic Graph, DAG)**。

```
    Snapshot 1 (初始提交)
         |
         v
    Snapshot 2 (添加功能)
         |
    +----+----+
    |         |
    v         v
Snapshot 3  Snapshot 4
(修复 bug)  (开发功能)
    |         |
    +----+----+
         |
         v
    Merge Commit (合并提交，有两个父节点)
```

**关键特性**：
- 每个快照可以指向多个"父节点"
- 普通提交指向一个父节点
- **合并提交 (Merge Commit)** 指向多个父节点
- 整个历史图是**不可变的 (Immutable)**

### 历史不可变性

> Git 的设计原则：历史是只可追加 (append-only) 的

- 不能修改已存在的 commit、tree 或 blob
- 只能创建新的对象
- 类似于"不能穿越时空改变历史"

如果需要"撤销"效果：
- **未共享时**：使用 `git rebase` 重写历史
- **已共享时**：使用 `git revert` 创建"反做"提交

---

## 4. 对象与引用

### 对象存储 (Object Store)

Git 使用 **内容寻址 (Content-Addressed)** 的方式存储所有数据：

```python
# SHA-1 哈希作为 key
objects = map<string, blob | tree | commit>

def store(obj):
    id = sha1(obj)  # 计算 SHA-1 哈希
    objects[id] = obj
    return id

def load(id):
    return objects[id]
```

**SHA-1 哈希**：
- 输入任意长度数据
- 输出 160 位（40 个十六进制字符）的固定长度值
- 确定性：相同内容总是产生相同哈希
- 唯一性：不同内容极大概率产生不同哈希

### 引用 (Reference)

40 位的十六进制哈希对人极不友好，Git 引入了**引用**：

```python
# 引用是可变指针，指向 commit
refs = map<string, string>  # 名称 -> SHA-1 哈希

# 例如：
# refs: master -> "a0b1c2d3..."
#       main   -> "e4f5g6h7..."
#       anish  -> "i8j9k0l1..."
```

**引用类型**：
- **分支 (Branch)**：移动的指针，随提交自动更新
- **标签 (Tag)**：通常指向重要版本，通常不移动
- **HEAD**：特殊引用，指向当前所在位置

```bash
# HEAD 指向当前分支
HEAD -> main -> commit_a0b1c2
```

### Git 仓库的组成

> **Git 仓库 = 对象 + 引用**

```
.git/
├── objects/   # 所有对象（blob、tree、commit）
└── refs/      # 所有引用（分支、标签等）
```

---

## 5. 暂存区 (Staging Area)

### 问题背景

如果直接提交当前目录的所有变化，可能导致：
- 想分开提交的两个功能被混在一起
- 提交粒度不清晰

### Git 的解决方案

暂存区让你可以**精心挑选**哪些改动放入下一个快照：

```
工作目录          暂存区 (Index)        Git 仓库
   |                    |                  |
   |-- git add file --> |                  |
   |                    |-- git commit --->|
```

### 命令流程

```bash
# 修改文件
edit some_file.txt

# 将修改加入暂存区
git add some_file.txt

# 从暂存区创建提交
git commit -m "描述"
```

---

## 6. 基础命令实战

### 初始化仓库

```bash
# 创建新仓库
git init

# 目录中会出现 .git 文件夹
# .git/objects 和 .git/refs 存储数据
```

### 查看状态

```bash
git status
```

输出示例：
```
On branch master
No commits yet
nothing to commit (create/copy files and use "git add")
```

### 添加与提交

```bash
# 将文件加入暂存区
git add filename.txt

# 创建提交（会弹出编辑器写 commit message）
git commit

# 或者直接在命令行指定消息
git commit -m "Your commit message"
```

### 查看历史

```bash
# 线性历史
git log

# 显示图形化历史
git log --graph --oneline --all

# 显示每次提交的 diff
git log -p
```

### 深入查看对象

```bash
# 查看对象类型
git cat-file -t <hash>

# 查看对象内容
git cat-file -p <hash>
```

输出示例：
```
tree 9a1b2c3d4e5f...
author User <user@example.com> 1234567890 +0000
committer User <user@example.com> 1234567890 +0000

    Initial commit

alpha.txt
beta.txt
```

---

## 7. 分支操作

### 创建分支

```bash
# 创建新分支（指向当前 commit）
git branch feature-branch

# 创建并切换到新分支
git switch -c feature-branch # 1
git checkout -b feature-branch # 2
```

### 切换分支

```bash
# 切换到已存在的分支
git switch main # 1
git checkout main # 2
```

**注意**：切换分支会改变工作目录的内容！

### 查看分支

```bash
# 列出所有本地分支
git branch

# 显示所有分支（包括远程）
git branch -a
```

输出示例：
```
* main          # * 表示当前分支
  anish         # 绿色表示在某些工具中是高亮分支
  old
```

### 删除分支

```bash
# 安全删除（不能删除当前分支）
git branch -d branch-name

# 强制删除
git branch -D branch-name
```

### 关键概念

> **分支只是一个指向 commit 的指针，不是整条历史线**

```
     main
       |
       v
    commit A
       |
       v
    commit B <-- anish
       |
       v
    commit C (HEAD)
```

---

## 8. 合并 (Merge)

### 基本合并

```bash
# 切换到要合并到的分支
git switch main

# 合并指定分支
git merge feature-branch
```

### 合并场景分析

**场景 1：快进合并 (Fast-forward)**

```
main:    A -- B -- C
                    \
anish:                D -- E
```

执行 `git switch main && git merge anish` 后：

```
main:    A -- B -- C -- D -- E
                           \
anish:                      (指针移动到 E)
```

**场景 2：三方合并**

```
main:    A -- B -- C
                    \
anish:                D -- E
```

合并后创建 **Merge Commit**：

```
main:    A -- B -- C -------
                    \       \
anish:                D -- E -- M (Merge Commit)
                                   /      \
                           parent C       parent E
```

### 解决冲突

当 Git 无法自动合并时（如同一文件同一位置被不同修改）：

1. Git 会标记冲突文件
2. 手动编辑文件解决冲突
3. `git add` 标记已解决
4. `git commit` 完成合并

```bash
# 查看冲突状态
git status

# 查看冲突详情
git diff

# 使用合并工具
git mergetool
```

---

## 9. 远程仓库与协作

### GitHub 简介

- **GitHub**：Git 仓库托管服务（软件即服务）
- 不是 Git 的一部分，是第三方平台
- 类似服务还有 GitLab、Bitbucket

### 添加远程仓库

```bash
# 添加远程仓库
git remote add origin https://github.com/user/repo.git

# 查看远程仓库
git remote -v
```

### 推送 (Push)

```bash
# 推送到远程仓库
git push origin main

# 设置上游分支并推送
git push -u origin main

# 之后可以直接 push
git push
```

`-u` (--set-upstream) 的作用：
- 建立本地分支与远程分支的追踪关系
- 之后 push/pull 不必指定远程和分支名

### 拉取 (Pull/Fetch)

```bash
# 获取远程更新并合并到当前分支
git pull

# 仅获取远程数据，不合并
git fetch

# 之后手动合并
git merge origin/main
```

### 克隆仓库

```bash
# 克隆远程仓库到本地
git clone https://github.com/user/repo.git

# 进入目录
cd repo
```

### 完整协作流程

```
用户 A (本地)              GitHub               用户 B (本地)
     |                      |                      |
     |---- git push ------>|                      |
     |                      |<--- git clone ----- |
     |                      |<--- git push -------|
     |<---- git pull ------|                      |
```

---

## 10. 其他常用命令

### 查看差异 (Diff)

```bash
# 查看工作区 vs 暂存区
git diff

# 查看暂存区 vs 最新提交
git diff --staged

# 比较两个分支
git diff main..anish

# 比较两个提交
git diff abc123..def456

# 查看特定文件的变化
git diff -- file.txt
```

### 检出旧版本

```bash
# 切换到某个分支
git switch branch-name

# 切换到某个提交（分离 HEAD 状态）
git switch --detach abc123
```

### 分离 HEAD 状态 (Detached HEAD)

- HEAD 正常指向分支
- 分离 HEAD 时，HEAD 直接指向某个 commit
- 在此状态做的新提交**没有分支指向**，会被 GC 回收

```bash
# 查看当前 HEAD 指向
cat .git/HEAD

# 如果显示类似 "ref: refs/heads/main"，说明在分支上
# 如果显示类似 "abc123..."，说明是分离 HEAD 状态
```

### 恢复误删分支

```bash
# 查看引用日志
git reflog

# 从 reflog 恢复
git checkout -b recovered-branch abc123
```

### 其他实用命令

```bash
# 撤销工作区的修改（恢复到暂存区状态）
git checkout -- file.txt

# 取消暂存
git reset HEAD file.txt

# 查看谁最后修改了某行
git blame file.txt

# 清理未跟踪文件
git clean -f

# 交互式 rebase（重写历史）
git rebase -i HEAD~3
```

---

## 11. 总结与学习资源

### 核心概念回顾

| 概念 | 说明 |
|------|------|
| Blob | 文件内容 |
| Tree | 目录 |
| Commit | 快照 + 元数据 |
| Reference | 可变指针（分支、标签、HEAD） |
| SHA-1 Hash | 对象的唯一标识 |
| Staging Area | 暂存区，控制提交内容 |

### 常用命令速查

```bash
# 初始化与配置
git init                    # 初始化仓库
git clone <url>             # 克隆仓库
git config --global user.name "Your Name"

# 日常操作
git status                  # 查看状态
git add <file>              # 暂存文件
git commit -m "message"    # 提交
git log --oneline --graph   # 查看历史

# 分支操作
git branch                  # 列出分支
git branch -c <name>        # 创建分支
git switch <branch>       # 切换分支
git merge <branch>          # 合并分支
git branch -d <branch>      # 删除分支

# 远程协作
git remote add origin <url> # 添加远程
git push -u origin main     # 推送
git pull                    # 拉取
git fetch                   # 获取

# 查看与比较
git diff                    # 查看差异
git diff --staged           # 暂存区差异
git show <hash>             # 查看提交详情
git log -p                  # 带 diff 的历史

# 底层命令
git cat-file -t <hash>      # 查看对象类型
git cat-file -p <hash>      # 查看对象内容
```

### 推荐学习资源

| 资源 | 说明 |
|------|------|
| [Pro Git Book](https://git-scm.com/book/zh/v2) | 官方权威教程 |
| [Git 内部原理](https://git-scm.com/book/zh/v2/Git-内部原理) | 理解底层实现 |
| [Git Flight Rules](https://github.com/k88hudson/git-flight-rules) | 常见问题解决方案 |
| [Oh Shit, Git!?!](https://ohshitgit.com/) | 错误恢复指南 |

### 良好实践

1. **commit message**：写清楚做了什么、为什么做
2. **小提交**：每次提交完成一个独立的功能或修复
3. **分支开发**：新功能开分支，开发完再合并
4. **保护主分支**：重要分支设置保护规则
5. **理解后再 push**：推送前确保理解了变更内容

---

## 常见问题 FAQ

### Q: 分支和提交有什么区别？

**A**: 
- **Commit** 是一个数据结构，包含快照、父提交、元数据
- **Branch/Reference** 只是一个指向某个 commit 的可变指针
- 提交追踪历史，分支只是命名标记

### Q: master 和 main 有什么区别？

**A**: 两者只是命名约定的区别。旧版 Git 默认分支名是 `master`，新版和 GitHub 默认使用 `main`。可以随时重命名。

```bash
git branch -m master main  # 重命名
```

### Q: 如何撤销上一次的提交？

```bash
# 如果还没 push（重写本地历史）
git reset --soft HEAD~1    # 保留更改在暂存区
git reset --mixed HEAD~1   # 保留更改在工作区（默认）
git reset --hard HEAD~1    # 丢弃更改

# 如果已经 push（创建反向提交）
git revert HEAD
git push

# 撤销某一次 push 的提交
git log --online # 找到提交ID
git revert 提交ID
git push
```

通过 revert 撤销不改变历史，只会往后加节点
### Q: 合并冲突了怎么办？

1. 打开冲突文件，搜索 `<<<<<<<`
2. 手动保留需要的代码
3. 删除冲突标记符号
4. `git add <file>` 标记已解决
5. `git commit` 完成合并

### Q: 误删分支怎么恢复？

```bash
# 查看 reflog
git reflog

# 找到删除前的 commit hash，创建新分支
git checkout -b <branch-name> <hash>
```