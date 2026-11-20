
1. 查看包安装目录 `.libPaths()`
2. 查看已安装包 `library()`
3. 查看已载入包 `search()`

安装包使用函数
```R
install.packages("name")
```
name 可以为包名，或是本地 zip 文件

可以指定镜像源，如：
```R
install.packages("XML", 
	repos = "https://mirrors.ustc.edu.cn/CRAN/")
```

载入包用命令：
```R
library("name")
```
