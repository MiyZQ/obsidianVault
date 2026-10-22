
首先要理解概念：
- 工作区：文件区
- 暂存区：`git add` 进去的缓存
- 本地仓库：`git commit` 保存的历史版本

## 撤销删除文件还未提交的状态

```bash
git restore .
```

可以同时清除暂存区、恢复工作区文件
## 撤销 git add

将所有文件退出暂存区：

```bash
git reset HEAD .
```

只撤销单个文件：

```bash
git reset HEAD <filename>
```

## 撤销工作区修改，恢复成上次 commit 状态

恢复单个文件：

```bash
git checkout -- <filename>
```

恢复所有文件：

```bash
git checkout -- .
```

> [!ATTENTION] 
> 上面操作后本地未保存修改会直接丢失！

## 清理未跟踪文件

未跟踪文件指，没有 add、没有 commit 的新增文件

```bash
git clean -n   # 先预览要删除的文件
git clean -f   # 删文件不删文件夹
git clean -fd  # 还删未跟踪文件夹
git clean -fdx # 还删.gitignore忽略的文件
```

## 彻底重置本地仓库，回到最近 commit

### soft 软重置

返回上一次提交，而新文件、暂存、本地修改保留

> 适用于提交错代码，重新去整理提交

```bash
git reset --soft HEAD^
```

### mixed 混合重置

返回上一次提交，取消暂存，保留本地修改、新文件

```bash
git reset HEAD^
```

### hard 硬重置

返回上一次提交，删除新文件、暂存、本地修改

```bash
git reset --hard HEAD^
```

## 清理远程残留

> 如果改完 .gitignore 不生效，或已经跟踪的文件想取消跟踪，可以清理全局缓存

```bash
git rm -r --cached .
git add .
git commit -m "clean cache"
```

## 组合命令

清除新文件、本地修改、暂存，将仓库还原为上一次 commit：
```bash
git reset HEAD .
git checkout -- .
git clean -fd
```