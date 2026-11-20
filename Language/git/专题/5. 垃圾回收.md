
> 主要用于减小 .git 文件的大小，一般 git 有自动 gc

使用 `git count-objects -v` 可以查看有多少松散对象，占用多少空间

## 前提

使用前应保证工作区干净，无未提交修改；使用时不要中断，防止对象损坏

## 核心命令

1. 只清理确定无用的松散对象，不强行压缩：

```bash
git gc
```

2. 深度压缩，重新打包所有对象（可能不适合大仓库）：

```bash
git gc --aggressive
```

使用前可以使用 `git gc --no-prune` 来统计，不会删除数据

## 清理引用日志

> reflog 会记录所有 HEAD 变动，如 reset、切换分支等，长期堆积也会占用空间

```bash
git reflog expire --expire=now --all # 清理过期 reflog
git gc --prune=now # 同时清理引用日志
```