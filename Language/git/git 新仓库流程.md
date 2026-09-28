
#### 初始化
```bash
git init

# 设置身份
git config --global user.name "..."
git config --global user.email "..."

# 关联远程仓库
git remote add origin https://github.com/username/pero.git
```


> 如果关联仓库时出错了，先删除关联 `git remote remove origin`，再重新关联
> 此外，根目录下配置 .gitignore 文件忽略一些文件被提交
#### 日常提交
```bash
git status

git add .
git commit -m "fixd:..."

# 首次推送用第一个指定分支，此后只需第二个
git push -u origin main
git push

# 第二个实则是第一个简写，第一个还可指定拉取别的分支
git pull origin main
git pull
```

> 如果本地 git 分支名为 master 但 github 上为 main，可考虑修改本地分支名 `git branch -M main`

> [!NOTE]
> 用 `git add -u` 可以只提交修改的文件，不新增陌生文件