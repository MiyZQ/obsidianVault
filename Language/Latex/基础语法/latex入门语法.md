---
title: "30 分钟入门LaTeX（超级无敌详细版—无需下载配环境）"
source: "https://blog.csdn.net/2301_79168784/article/details/148934894?ops_request_misc=elastic_search_misc&request_id=cb77191e0c9f2af96f07691fb617346b&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~top_positive~default-2-148934894-null-null.142^v102^pc_search_result_base5&utm_term=latex&spm=1018.2226.3001.4187"
author:
  - "[[2301_79168784]]"
published: 2025-06-26
created: 2026-05-24
description: "文章浏览阅读1.3w次，点赞84次，收藏227次。LaTeX（发音为 “LAY-tek” 或 “LAH-tek”）是一种用于排版具有专业外观文档的工具。但是，LaTeX 的工作模式与您可能使用过的许多其他文档制作应用程序（例如 Microsoft Word 或 LibreOffice Writer）完全不同：这些“所见即所得”工具为用户提供了一个交互式页面，他们可以在其中键入和编辑文本并应用各种形式的样式。LaTeX 的工作方式非常不同：您的文档是一个纯文本文件，其中穿插着用于表达所需（排版）结果的 LaTeX命令。_latex"
tags:
  - "clippings"
---
## 30 分钟入门LaTeX

本入门教程不要求您有任何 LaTeX 的先前经验。希望当您读完时， **不仅能写出您的第一个 LaTeX 文档** ，还能够获得足够的知识和信心， **迈出精通 LaTeX 的下一步** 。

使用线上 **Overleaf** 进行讲解（推荐），点击进入，同步操作学习效果更佳 👉 [overleaf](https://cn.overleaf.com/)

---

##### 内容目录

1. **什么是 LaTeX？**
2. **为什么要学习 LaTeX？**
3. **编写您的第一个 LaTeX 文档**
4. **文档的序言（Preamble）**
5. **添加标题、作者和日期信息**
6. **添加注释**
7. **粗体、斜体和下划线**
8. **添加图片**
9. **图注、标签和引用**
10. **在 LaTeX 中创建列表**
11. **在 LaTeX 中添加数学公式**
12. **基本文档结构**
13. **创建表格**
14. **添加目录**
15. **下载您完成的文档**
16. **查找和使用 LaTeX 宏包**
17. **使用中文进行编译**

#### 1\. 什么是 LaTeX？

LaTeX（发音为 **“LAY-tek” 或 “LAH-tek”** ）是一种用于排版具有专业外观文档的工具。

但是，LaTeX 的工作模式与您可能使用过的许多其他文档制作应用程序（例如 **Microsoft Word** 或 **LibreOffice Writer** ）完全不同。

这些“所见即所得”工具为用户提供了一个交互式页面，而 LaTeX 的工作方式是：

- 您的文档是一个 **纯文本文件**
- 其中穿插着用于表达所需结果的 **LaTeX 命令**
- 最终由 **TeX 引擎** 编译成专业 PDF

因此， **您只需要专注于文档的内容** ，而计算机会通过 LaTeX 命令来 **负责视觉外观（格式）** 。

---

#### 2\. 为什么要学习 LaTeX？

是否要学习 LaTeX，取决于 **个人偏好、亲和力以及文档需求** 。

**支持学习 LaTeX 的理由包括：**

- **强大的排版能力** ：能轻松处理复杂数学公式、表格、学术内容
- **便捷的辅助功能** ：如脚注、交叉引用、参考文献管理
- **自动化文档元素** ：目录、索引、图表列表等
- **高度可定制** ：通过宏包扩展，实现强大灵活性

📌 **核心优势** ：LaTeX 实现了 **内容与样式分离** 。你可以复用模板，快速生成不同风格的排版效果。

例如，科学出版社会提供 **LaTeX 文章模板** ，作者写论文时只需专注于内容，排版由模板负责。

另外，Overleaf 提供了一个 **模板库** ，涵盖论文、报告、书籍、简历、演示文稿等多种场景。

#### 3\. 编写您的第一个 LaTeX 文档

第一步是创建一个新的 LaTeX 项目。您可以在自己的计算机上创建一个新的 **.tex 文件** ，或者在 **Overleaf** 上开始一个新项目。

让我们从最简单的有效示例开始（ **最小工作示例** ）：

```latex
\documentclass{article}

\begin{document}
First document. This is a simple example, with no
extra parameters or packages included.
\end{document}
latex123456
```

这个例子会产生以下输出：

![在这里插入图片描述](https://i-blog.csdnimg.cn/direct/103714a3a98c4308b1b34f1fb4d2c279.png)

您可以看到， **LaTeX 已经自动缩进了段落的第一行** ，为您处理了这种格式。让我们仔细看看我们代码的每个部分的作用。

代码的首行 `\documentclass{article}` 用于声明文档的 **“类”（class）** ，它决定了整个文档的 **视觉风格** 。例如，科技论文通常使用 `article` 类，而简历则会采用专门的 `resume` 或 `cv` 类，以确保其 **格式符合规范** 。除了 `article` ， **LaTeX** 还内置了 `book` 和 `report` 等多种类，以满足不同文档类型的 **排版需求** 。

设置了文档类之后，我们的内容，即文档的 **主体（body）** ，写在 `\begin{document}` 和 `\end{document}` 标签之间。在 **Overleaf** 中打开上述示例后，您可以更改文本，完成后，通过 **重新编译（Recompile）** 文档来查看最终排版的 **PDF** 。

#### 4\. 文档的序言（Preamble）

在 **LaTeX** 中， `\begin{document}` 命令之前的所有内容统称为 **序言 (Preamble)** 。  
您可以将序言视为 **文档的全局设置区** ，它负责定义文档的 **基础结构和功能** 。

在这里，您需要：

- 声明文档的 **类型 (class)**
- 指定文档 **语言**
- 加载需要使用的 **宏包 (packages)**
- 并完成其他必要的配置

文档的正文内容则写在 `\begin{document}` 之后。

一个最小的文档序言可能如下所示：

```latex
\documentclass[12pt, letterpaper]{article}
\usepackage{graphicx}
latex12
```

这里， `\documentclass[12pt, letterpaper]{article}` 定义了文档的 **整体类别（类型）** 。  
方括号 `[...]` 中包含了用于配置此 `article` 类的 **附加参数** ，这些参数必须用逗号分隔。

在这个例子中，两个参数的作用如下：

- **12pt** → 设置字体大小
- **letterpaper** → 设置纸张尺寸

当然，也可以使用其他字体大小，如 **9pt** 、 **11pt** 。如果没有指定，默认大小是 **10pt** 。  
至于纸张大小，常见的还有 **a4paper** 和 **legalpaper** 。

序言中的 `\usepackage{graphicx}` 命令用于加载 **graphicx 宏包** 。该 宏 包扩展了 LaTeX 的核心功能，允许您在文档中插入并管理外部 **图形文件** 。

---

#### 5\. 添加标题、作者和日期信息

要在文档中添加 **标题** 、 **作者** 和 **日期** ，需要在 **序言** （不是文档主体）中添加三行代码：

- `\title{My first LaTeX document}` → 文档的 **标题**
- `\author{Hubert Farnsworth}` → 填写 **作者姓名**
	- 也可以加上 `\thanks{Funded by the Overleaf team.}` ：  
		会在作者名后生成一个 **上标脚注**
- `\date{August 2022}` → 自定义日期
	- 或使用 **\\today** 自动插入 **编译当天日期**

添加这些行后，您的序言应该如下所示：

```latex
\documentclass[12pt, letterpaper]{article}
\title{My first LaTeX document}
\author{Hubert Farnsworth\thanks{Funded by the Overleaf team.}}
\date{August 2022}
latex1234
```

要在文档 **主体** 中排版标题、作者和日期，请使用 `\maketitle` 命令：

```latex
\begin{document}
\maketitle
We have now added a title, author and date to our first \LaTeX{} document!
\end{document}
latex1234
```

现在，将序言和主体结合起来，可以生成一个完整的文档：

```latex
\documentclass[12pt, letterpaper]{article}

\title{My first LaTeX document}
\author{Hubert Farnsworth\thanks{Funded by the Overleaf team.}}
\date{August 2022}

\begin{document}
\maketitle
We have now added a title, author and date to our first \LaTeX{} document!
\end{document}
latex12345678910
```

> [!NOTE]
> `\maketitle` 相当于将 document 环境前的 title、author、date 等 cover 元素插入到 document 环境中

#### 6\. 添加注释

**LaTeX** 是一种专门用于文档排版的 “ **程序代码** ”；  
因此，就像用任何其他编程语言编写的代码一样，在文档中包含 **注释** 非常有用。

LaTeX **注释** 是一段 **不会被排版、也不会影响文档** 的文本。

要在 LaTeX 中添加注释，只需在该行的开头写一个 **% 符号** ，如下例所示：

```latex
\documentclass[12pt, letterpaper]{article}

\title{My first LaTeX document}
\author{Hubert Farnsworth\thanks{Funded by the Overleaf team.}}
\date{August 2022}

\begin{document}
\maketitle
We have now added a title, author and date to our first \LaTeX{} document!
% This line here is a comment. It will not be typeset in the document.
\end{document}
latex1234567891011
```

#### 7\. 粗体、斜体和下划线

接下来，我们将看一些 **文本格式化命令** ：

- **粗体** ：使用 `\textbf{...}` 命令
- **斜体** ：使用 `\textit{...}` 命令
- **下划线** ：使用 `\underline{...}` 命令

下面的示例演示了这些命令：

```latex
Some of the \textbf{greatest}
discoveries in \underline{science}
were made by \textbf{\textit{accident}}.
latex123
```

另一个非常有用的命令是 `\emph{...}` ，其效果取决于上下文。在普通文本中，强调的文本是斜体，但如果在斜体文本中使用，此行为会反转。

```latex
Some of the greatest \emph{discoveries} in science
were made by accident.

\textit{Some of the greatest \emph{discoveries}
in science were made by accident.}

\textbf{Some of the greatest \emph{discoveries}
in science were made by accident.}
latex12345678
```

#### 8\. 添加图片

学习如何向 **LaTeX 文档** 添加图片。 在此之前，您需要先将图片 **上传到项目** 中。

以下示例演示了如何 **包含图片** ：

```latex
\documentclass{article}
\usepackage{graphicx} % 用于导入图形的 LaTeX 宏包
\graphicspath{{images/}} % 配置 graphicx 宏包

\begin{document}

The test image you can see.

\includegraphics[width=0.9\textwidth]{test}

There's a picture of a galaxy above.
\end{document}
latex123456789101112
```

将图形导入 **LaTeX 文档** 需要一个附加的 **宏包** 。上述示例加载了 `graphicx` 宏包，它提供了：

- **\\includegraphics{…}** → 用于导入图形
- **\\graphicspath{…}** → 告知 LaTeX 图像文件夹的位置

在我们的示例中：

- `\graphicspath{{images/}}` 命令告知 LaTeX 图片保存在当前目录下的 **images 文件夹**
- `\includegraphics{test}` 命令实际插入图片
- `[width=0.9\textwidth]` 表示图像占 **文本宽度的 0.9 倍**
- 这里 `test` 是图片文件名，但 **不带扩展名**

> [!attention]
> 省略文件扩展名是最佳实践，因为这会提示 LaTeX 搜索所有支持的格式。

> [!NOTE]
>   可以如下引入宏包
>   ```latex
>   \usepackage[justification=centering,labelsep=period]{caption}
>   ```
>   优化 figure、table 环境排版，将默认的左对齐改为居中对齐，图表标题分隔符改成 `.` 也更符合中文规范

#### 9\. 图注、标签和引用

图片可以通过 **`figure` 环境** 来添加 **图注（caption）** 、 **标签（label）** 和 **引用（reference）** ，如下所示：

```latex
\documentclass{article}
\usepackage{graphicx}
\graphicspath{{images/}}

\begin{document}

\begin{figure}[h]
\centering
\includegraphics[width=0.75\textwidth]{mesh}
\caption{A nice plot.}
\label{fig:mesh1}
\end{figure}

As you can see in figure \ref{fig:mesh1}, the function grows near the origin. This example is on page \pageref{fig:mesh1}.

\end{document}
latex12345678910111213141516
```

这个例子中有几个值得注意的命令：

- **\\includegraphics\[width=0.75\\textwidth\]{mesh}**  
	👉 指示 LaTeX 将图形的宽度设置为 **文本宽度的 75%** 。
- **\\caption{A nice plot.}**  
	👉 设置图形的 **标题（caption）** 。
- **\\label{fig:mesh1}**  
	👉 给该图片分配一个 **标签（label）** ，以便后续引用。
- **\ref{fig:mesh1}**  
	👉 在文档中引用时，会被替换为图片的 **编号** 。
- **\\pageref{fig:mesh1}**  
	👉 在文档中引用时，会被替换为该图片所在的 **页码** 。

figure 环境的*可选参数* 除了 h 还有：

| 字符  | 含义      | 说明                       |
| --- | ------- | ------------------------ |
| h   | here    | 当前位置                     |
| t   | top     | 页面顶部                     |
| b   | bottom  | 页面底部                     |
| p   | page    | 单独浮动页                    |
| !   | 强制      | 忽略 latex 排版限制            |
| H   | 强制 here | 依赖包 `\usepackage{float}` |
上面的字符可以组合，按场景分类有
1. 首选论文/书籍插图：`[ht]`
2. 图片大，容易挤到下一页：`[htp]`、`[htbp]`
3. 排版错位，空间够但挪图：`[!ht]`
4. 必须卡死位置（草稿/课件）：`[H]`
5. 期刊要求图置顶：`[t]`、`[tb]`

插入到 LaTeX 文档中的图片应该放在 `figure` 环境中，这样 LaTeX 就可以自动将图片放置在文档中的合适位置。  

#### 10\. 在 LaTeX 中创建列表

您可以使用 **环境 (environments)** 创建不同类型的列表。 一个环境以 `\begin{environment-name}` 开始，并以 `\end{environment-name}` 结束。

---

##### 无序列表

无序列表由 **`itemize` 环境** 产生。  
每个列表项必须以 **\\item 命令** 开头，如下所示：

```latex
\documentclass{article}
\begin{document}

\begin{itemize}
\item The individual entries are indicated with a black dot, a so-called bullet.
\item The text in the entries may be of any length.
\end{itemize}

\end{document}
latex123456789
```

##### 有序列表

有序列表使用与无序列表相同的语法，  
但是通过 **`enumerate` 环境** 创建：

```latex
\documentclass{article}
\begin{document}

\begin{enumerate}
\item This is the first entry in our list.
\item The list numbers increase with each entry we add.
\end{enumerate}

\end{document}
latex123456789
```

与无序列表一样，每个条目都必须以 `\item` 命令开头，这里它会自动生成从 1 开始的数字列表标签。  

#### 11\. 在 LaTeX 中添加数学公式

**LaTeX** 的主要优点之一是能够轻松编写 **数学表达式** 。  
它提供了两种排版数学公式的模式：

- **行内 (inline) 数学模式** ：用于书写作为段落一部分的公式
- **陈列 (display) 数学模式** ：用于独立成行的表达式

---

##### 行内数学模式

来看一个行内数学模式的例子：

要排版行内数学公式，你可以使用以下定界符之一：

- **( … )**
- **…**
- **\begin{math} … \end{math}**

```latex
\documentclass[12pt, letterpaper]{article}
\begin{document}
In physics, the mass-energy equivalence is stated
by the equation $E=mc^2$, discovered in 1905 by Albert Einstein.
\end{document}
latex12345
```

输出：

> In physics, the mass-energy equivalence is stated by the equation $E=mc^2$, discovered in 1905 by Albert Einstein.

##### 陈列数学模式

以陈列模式排版的方程式可以 **编号** 或 **不编号** 。

要排版陈列数学公式，您可以使用以下定界符之一： 
-  `\[ ... \]` 
- `\begin{displaymath} ... \end{displaymath}` 
- `\begin{equation} ... \end{equation}` 

历史上，也曾使用 `$$...$$` ，但现在 **不推荐** 使用。

```latex
\documentclass[12pt, letterpaper]{article}
\begin{document}
The mass-energy equivalence is described by the famous equation
\[ E=mc^2 \]
discovered in 1905 by Albert Einstein.

In natural units ($c = 1$), the formula expresses the identity
\begin{equation}
E=m
\end{equation}
\end{document}
latex1234567891011
```

输出：

> The mass-energy equivalence is described by the famous equation  $$E=mc^2$$
> discovered in 1905 by Albert Einstein.
> 
> In natural units (), the formula expresses the identity $$E=m$$

##### 更完整的示例

以下示例展示了使用 LaTeX 排版的各种数学内容。

```latex
\documentclass{article}
\begin{document}
Subscripts in math mode are written as $a_b$ and superscripts are written as $a^b$. These can be combined and nested to write expressions such as
\[ T^{i_1 i_2 \dots i_p}_{j_1 j_2 \dots j_q} = T(x^{i_1},\dots,x^{i_p},e_{j_1},\dots,e_{j_q}) \]

We write integrals using \verb|\int| and fractions using \verb|\frac{a}{b}|. Limits are placed on integrals using superscripts and subscripts:
\[ \int_0^1 \frac{dx}{e^x} =  \frac{e-1}{e} \]

Lower case Greek letters are written as $\omega$ $\delta$ etc. while upper case Greek letters are written as $\Omega$ $\Delta$.

Mathematical operators are prefixed with a backslash as $\sin(\beta)$, $\cos(\alpha)$, $\log(x)$ etc.
\end{document}
latex123456789101112
```

#### 12\. 基本文档结构

接下来，我们将探讨 **摘要** 以及如何将 **LaTeX 文档** 划分为不同的 **章节、节和段落** 。

---

##### 摘要

在 **科技文章** 和 **学术论文** 中， **摘要 (Abstract)** 是不可或缺的一部分。  
它浓缩了全文的 **精华** ，让读者能快速了解文章的 **核心内容** 、 **研究方法** 和 **主要结论** 。

在 **LaTeX** 中，我们可以使用 **abstract 环境** 来轻松、规范地排版摘要。

```latex
\documentclass{article}
\begin{document}
\begin{abstract}
This is a simple paragraph at the beginning of the
document. A brief introduction about the main subject.
\end{abstract}
\end{document}
latex1234567
```

##### 段落和换行

写完摘要后，我们可以开始写第一段。  
下一个示例演示了：

- 如何通过 **按两次回车键** （即插入一个空行）来创建一个 **新段落**，或使用 **\par** 命令
- 如何通过插入 **手动换行符 `\\`** （双反斜杠）来开始一个 **新行** 而不开始新段落 或者，使用 **\\newline 命令** 达到同样效果
```latex
\documentclass{article}
\begin{document}
\begin{abstract}
This is a simple paragraph at the beginning of the
document. A brief introduction about the main subject.
\end{abstract}

After our abstract we can begin the first paragraph, then press \`\`enter'' twice to start the second one.

This line will start a second paragraph.

I will start the third paragraph and then add \\ a manual line break which causes this text to start on a new line but remains part of the same paragraph. Alternatively, I can use the \verb|\newline|\newline command to start a new line, which is also part of the same paragraph.
\end{document}
latex12345678910111213
```

请注意 LaTeX 如何自动缩进段落——除非紧跟在章节标题之后。  

##### 章节

较长的文档通常被划分为 **部分** 、 **章** 、 **节** 、 **小节** 等。

**LaTeX** 提供了相应的 **结构化命令** ，但具体可用的命令及其效果可能取决于所使用的 **文档类** ：

- 使用 `book` 类的文档，可以分为  
	**\\part** 、 **\\chapter** 、 **\\section** 、 **\\subsection** 等
- 使用 `letter` 类的文档，则 **不支持这些结构**

---

下一个示例演示了用于构建基于 **`book` 类** 文档的命令：

```latex
\documentclass{book}
\begin{document}
\chapter{First Chapter}
\section{Introduction}
This is the first section.
Lorem  ipsum  dolor  sit  amet,  consectetuer  adipiscing
elit. Etiam  lobortisfacilisis sem.  Nullam nec mi et
neque pharetra sollicitudin.  Praesent imperdietmi nec ante.
Donec ullamcorper, felis non sodales...

\section{Second Section}
Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Etiam lobortis facilisissem.  Nullam nec mi et neque pharetra
sollicitudin.  Praesent imperdiet mi necante...

\subsection{First Subsection}
Praesent imperdietmi nec ante. Donec ullamcorper, felis non sodales...

\section*{Unnumbered Section}
Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Etiam lobortis facilisissem...
\end{document}
latex12345678910111213141516171819202122
```

分节命令的名称大多是 **不言自明** 的。 **节、小节等的编号** 是自动生成的， 但可以通过使用命令的 **“星号版本”** 来禁用编号。

例如：

- **\\section\*{…}**
- **\\subsection\*{…}**

#### 13\. ~~创建表格~~

> latex 的制作表格并不好用，可以忽略，一般可用 excel 转成 latex 语法

我们从一个展示如何排版 **基本表格** 的示例开始：

---

##### 在 LaTeX 中创建基本表格

```latex
\begin{center}
\begin{tabular}{c c c}
cell1 & cell2 & cell3 \\
cell4 & cell5 & cell6 \\
cell7 & cell8 & cell9
\end{tabular}
\end{center}
latex1234567
```

`tabular` 环境是 **LaTeX** 创建 表格 的 **默认方法** 。

您必须为此环境指定一个参数，本例中为 **{c c c}** ，它告知 LaTeX 将有 **三列** ，并且每列中的文本都必须 **居中对齐** 。

您也可以使用：

- **r** → 右对齐文本
- **l** → 左对齐文本

对齐符号 **&** 用于 **分隔表格行内的各个单元格** 。  
要结束一个表格行，请使用 **换行命令 `\\`** 。

##### 添加边框

`tabular` 环境支持将 **水平线** 和 **垂直线** 作为表格的一部分：

- 要添加 **水平线** ，请使用 **\\hline** 命令
- 要添加 **垂直线** ，请使用 **|** 参数

在此示例中，参数是 **{|c|c|c|}** ，  
它声明了 **三个（居中）列** ，且每列之间由一条 **垂直线** 分隔。

```latex
\begin{center}
\begin{tabular}{|c|c|c|}
\hline
cell1 & cell2 & cell3 \\
cell4 & cell5 & cell6 \\
cell7 & cell8 & cell9 \\
\hline
\end{tabular}
\end{center}
latex123456789
```

##### 表注、标签和引用

您可以像给 **图片** 添加图注和引用一样，  
给 **表格** 添加 **表注（caption）** 和 **引用（reference）** 。

唯一的区别是，这里使用 **`table` 环境** 而不是 **`figure` 环境** 。

```latex
\begin{table}[h!]
\centering
\begin{tabular}{||c c c c||}
\hline
Col1 & Col2 & Col2 & Col3 \\ [0.5ex]
\hline\hline
1 & 6 & 87837 & 787 \\
2 & 7 & 78 & 5415 \\
3 & 545 & 778 & 7507 \\
4 & 545 & 18744 & 7560 \\
5 & 88 & 788 & 6344 \\ [1ex]
\hline
\end{tabular}
\caption{Table to test captions and labels.}
\label{table:data}
\end{table}

Table \ref{table:data} shows how to add a table caption and reference a table.
latex123456789101112131415161718
```

#### 14\. 添加目录

创建目录非常简单，因为 **\\tableofcontents** 命令几乎为您完成了所有工作：

```latex
\documentclass{article}
\title{Sections and Chapters}
\author{Gubert Farnsworth}
\date{August 2022}
\begin{document}
\maketitle
\tableofcontents

\section{Introduction}
This is the first section.
Lorem  ipsum  dolor  sit  amet,  consectetuer  adipiscing
elit.   Etiam  lobortisfacilisis sem.  Nullam nec mi et
neque pharetra sollicitudin.  Praesent imperdietmi nec ante.
Donec ullamcorper, felis non sodales...

\section*{Unnumbered Section}
\addcontentsline{toc}{section}{Unnumbered Section}
Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Etiam lobortis facilisissem.  Nullam nec mi et neque pharetra
sollicitudin.  Praesent imperdiet mi necante...

\section{Second Section}
Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Etiam lobortis facilisissem.  Nullam nec mi et neque pharetra
sollicitudin.  Praesent imperdiet mi necante...
\end{document}
latex1234567891011121314151617181920212223242526
```

**节、小节和章** 会 **自动包含** 在目录中。 若要手动添加条目（例如 **未编号的节** ）， 请使用 **\\addcontentsline** 命令，如示例所示。

#### 15\. 下载您完成的文档

在 **Overleaf** 等在线平台，您通常可以找到一个 **“下载” 或 “导出” 按钮** ，

它允许您下载：

- 项目的 **源代码（.tex 文件及相关文件）**
- 或最终排版好的 **PDF 文件**

#### 16\. 查找和使用 LaTeX 宏包

**LaTeX** 不仅提供强大的排版功能，  
还通过使用附加的 **宏包 (packages)** 提供了一个 **可扩展框架** 。

---

##### 加载宏包

如前所述，宏包在文档 **序言** 中通过 **\\usepackage** 命令加载。

因为许多宏包提供了一组 **选项** ，可以用来配置其行为，所以命令通常写作：

`\usepackage[options]{somepackage}`

- 方括号 `[ ... ]` → 告诉 LaTeX 在加载 `somepackage` 时应用哪些 **选项**
- 如果没有选项，写法更简单： `\usepackage{somepackage}`
- LaTeX 会自动寻找一个名为 **somepackage.sty** 的文件并加载

---

##### 查找宏包信息：CTAN

宏包通过 **综合 TeX 档案网络 (CTAN)** 分发。  
截至目前，它已托管了来自 **2881 位贡献者** 的 **6287 个宏包** 。

您可以在 CTAN 上查找有用的宏包，例如：

- **按主题浏览**
- **按字母顺序浏览**
- **使用搜索功能**

##### Overleaf 上可用的宏包：TeX Live 简介

每年，CTAN 上托管的宏包的一个（大）子集，加上与 **LaTeX** 相关的字体和其他软件，会被整理并分发为一个名为 **TeX Live** 的系统。  
这可以用来安装您自己的（本地）LaTeX 环境。

实际上， **Overleaf 的服务器** 也使用 TeX Live，并会在新版 TeX Live 发布时 **及时更新** 。

- 尽管 TeX Live 包含了 CTAN 宏包的一个（大）子集，您仍可能发现部分宏包仅存在于 CTAN 上，却没有包含在 TeX Live 中，因此在 Overleaf 上 **不可用** 。
- 不过，Overleaf 平台已经涵盖了 **绝大多数常用宏包** ， 足以满足几乎所有的 **排版需求** 。

---

#### 17\. 使用 LaTeX 生成中文排版

```latex
\documentclass{article}
\usepackage{xeCJK}

\begin{document}
拉拉拉拉拉拉拉马

\end{document}
latex1234567
```

- 需要使用 `\usepackage{xeCJK}` 这个包
- 同时在菜单中将编译器换为 **XeLsTeX**