
基础可见[第五讲_版本控制与Git](../../AInote/计算机拾遗/第五讲_版本控制与Git.md)，其后内容按使用场景补充
另附 [git学习网站](https://learngitbranching.js.org/)

## 多协作下拉取

git 最佳实践中推荐每个人用独立的分支。当多人需同时解决同一个分支上的疑难问题，就有可能两个人使用同一个分支开发

如果 A 先 push 自己的分支到 remote，此时 B 再 push 时就会被 remote 拒绝，基本做法是：*将远端最新提交 pull 到本地*

但应注意，直接 `git pull` 在这场景会出现问题

> git pull 等同于 git fetch 和 git merge 两条命令，由于 B 的 commit 与 A 的 commit 有共同的祖先，在默认情况下会 merge 两个 commit 并创建一个额外的 merge 记录，长此以往给 tree 产生一推无用的 merge 信息，使得搜索 history 变得困难

#### 解决方案

使用 `git pull --rebase`，此命令会先将 B 的 commit 暂时放在一边，然后拉取 remote 的 commit，再将 B 的 commit 连在后面，保持了 commit history 的线性干净

在项目 terminal 中也可以修改默认设置使得 `git pull` 自动 rebase，命令为
`git config pull.rebase true`

## .gitignore 的一个坑

.gitignore 只对未被 git 跟踪的文件生效，下面有一个情景：

> 提交 demo.md 文件到 remote 后，在.gitignore 又添加了此文件，后续文件被修改后依然被上传给 remote

#### 解决方案

从 git 跟踪中移除这个文件，本地文件依然保留

```bash
git rm --cached <文件路径>
git add .
git commit -m "fixd:解决不必要插件数据上传问题"
git status
```

