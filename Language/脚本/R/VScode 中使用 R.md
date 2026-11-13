
需要在官网下载 R 语言：RProject.R（建议通过包管理），打开 R 终端输入执行：
```R
install.packages("languageserver")
install.packages("httpgd")
```

**在 VScode 中插件下载：**
> R、R Debugger

**在 VScode 中使用 radian 终端：**
以 uv 示例，在 VScode 中打开终端启用 uv，使用 `uv tool install` 命令可以自动生成一个专属隔离的隐藏虚拟环境，通过此命令可以隔离 radian 和其依赖包，环境与其他项目分开不冲突：
```bash
uv tool install --python 3.10 radian
```
把 `radian` 命令加入到系统 PATH 中：
```bash
uv tool update-shell
```

> [!NOTE]
> - 写项目适合用虚拟环境 `uv venv .venv`
> - 装全局命令行工具适合 tool 命令 `uv tool install`

在 settings 中搜索 `r.rterm.windows` 填入 radian 的文件路径，搜索 `r.br` 勾选 radian 为默认终端
![](assets/VScode%20中使用%20R/file-20260831162256279.png)

示例 settings：
```json
{
	"workbench.sideBar.location": "right",
    "r.rpath.windows": "...\\bin\\R.exe",
    "r.rterm.windows": "...\\bin\\radian.exe",
    "r.bracketedPaste": true,
    "r.plot.useHttpgd": true,
    "r.rterm.option": [],
    "r.sessionWatcher": true,
}
```

**设置快捷键：**
- ctrl+enter：执行当前代码并自动跳转下一行
- ctrl+shift+m：生成管道符快捷键 `%>%`

管道符使用如：
```R
library(magrittr)
runif(10) %>% round() %>% mean()
5 %>% rnorm(n=50,mean=.) # .号占位
```

**使用 httpgd 作为图片显示器：**
在 settings 中搜索 `httpgd` 勾选