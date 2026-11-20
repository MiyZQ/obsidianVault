
latex 可以使用 `\newcommand` 来自定义命令，一般可以直接写在主文档内，也可以令开一个 custom.tex 专门写自定义命令，主文档中 `\input{custom.tex}` ^1f60bf

语法：
```latex
\newcommand{新命令}{具体命令}
```

例子如

```latex
% 单位矢量
\newcommand{\ivec}{\mathbf{i}}
\newcommand{\jvec}{\mathbf{j}}
\newcommand{\kvec}{\mathbf{k}}
% 留数
\newcommand{\Res}{\mathop{\mathrm{Res}}}
```

也可使用 `renewcommand{}{}` 来重写自定义命令，使用场景：

理科的虚数单位用 $\mathrm{i}$，工科的虚数单位用 $\mathrm{j}$。当理科文档使用 `newcommand{\im}{\mathrm{i}}` 用.tex 引用单位时，工科文档复制理科文档，在后面加入 `renewcommand{\im}{\mathrm{j}}` 即可