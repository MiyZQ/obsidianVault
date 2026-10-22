
## 文档类型

命令
```latex
\documentclass[args]{beamer}
```

可选参数如下：
1. 全局垂直对齐方式：t 顶端对齐、c 居中对齐、b 底部对齐，默认 c
2. 字体大小：8 pt、9 pt、10 pt、...，默认 11 pt
3. 以紧凑方式展示导航栏内容：compress
4. 以讲义方式生成 PDF，取消动画方便打印：handout
5. 部分元素被简化以加速编译：draft
6. 改变演示文稿长宽比：aspectratio

> 由于 Beamer 默认自动载入一些宏包如 amsthm、color、CJK、hyperref 等，为了给这些宏包传参数也可写在可选参数中

### 改长宽比

以 `aspectratio=value` 的键值对形式传入参数，值如：

| value | 含义    |
| ----- | ----- |
| 2013  | 20:13 |
| 1610  | 16:10 |
| 169   | 16:9  |
| 149   | 14:9  |
| 141   | 14:1  |
| 54    | 5:4   |
| 43    | 4:3   |
| 32    | 3:2   |


### 配置中文

如果不使用模板，可直接指定中文 Beamer
```latex
\documentclass{ctexbeamer}
```

如果使用非标准文档类或模板等，可以导入宏包
```latex
\usepackage{ctex}
```

## 封面示例

可以类似文档类在导言区写好作者、标题等
```latex
\author{作者}
\title{主标题}
\subtitle{副标题}
\institute{机构}
\date{2026年5月20日}
```

直接像\maketitle 一样生成封面：
```latex
\begin{frame}
	\titlepage
\end{frame}
```

也可自己排版写，主要用到 beamercolorbox 环境
```latex
\begin{frame}
\begin{beamercolorbox}[sep=8pt,center,rounded=true]{title}
	\usebeamerfont{title}\inserttitle \par
	\usebeamerfont{subtitle}\insertsubtitle \par
\end{beamercolorbox}
\vspace{2em}
\begin{beamercolorbox}[center]{author}
	答辩人：\insertauthor \par
	指导老师：MIY \par
	\vspace{1em}
	\insertdate \par
\end{beamercolorbox}
\end{frame}
```

> [!NOTE] 自己排版的需求在：
> 原有生成的封面不能插入指导老师这一行，需要自定义


## 导出时的问题

默认导出 PDF 时是 100 的比例，而一般需要 200 的比例才能大且清晰

> 解决：打开导出的 PDF 选择打印，在打印选项新建一个更大尺寸的纸张，如 640 x 480，选择竖排方向、调整自适应