
```latex
\documentclass[12pt, letterpaper]{ctexart} % 中文环境用ctexart
\usepackage{float}
\usepackage{graphicx}
\usepackage{caption}
\graphicspath{{figures/}} % 指定 assets 路径

% cover 内容
\title{My first LaTeX document}
\author{Hubert Farnsworth\thanks{Funded by the Overleaf team.}}
\date{August 2022}


\begin{document}

% 文章内容
\maketitle
We have now added a title, author and date to our first \LaTeX{} document!

% 无序列表
\begin{itemize}
    \item This is the first item in our list.
    \item This is the second item in our list.
    \item This is the third item in our list.
\end{itemize}

% 有序列表
\begin{enumerate}
    \item This is the first item in our numbered list.
    \item This is the second item in our numbered list.
    \item This is the third item in our numbered list.
    \item This is the fourth item in our numbered list.
\end{enumerate}
\newpage

% 插入图片、图片 label 引用的运用，以及脚注的运用
\begin{figure}[htp]
    \centering
    \includegraphics[width=0.9\textwidth]{伊蕾娜}
    \caption{shes my waifu}\label{fig:my_waifu}
\end{figure}
如图\ref{fig:my_waifu}所示，irena。\footnote{括号内容添加到页面底部，不论这个段落被各种图表挤到哪一页}

% 边注
这是一句话\marginpar{也可插入 my waifu \\\includegraphics[width=0.9\marginparwidth]{伊蕾娜}\captionof{figure}{边注示例}}


\end{document}
```