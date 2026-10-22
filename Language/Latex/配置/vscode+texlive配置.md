
## 解读

```json
"latex-workshop.latex.autoBuild.run": "never"
```

设置何时使用默认的(第一个)编译链自动构建 LaTeX 项目，即什么时候自动进行代码的编译。有三个选项：

1. **onFileChange**：在检测任何依赖项中的文件更改(甚至被其他应用程序修改)时构建项目，即当检测到代码被更改时就自动编译tex文件；

2. **onSave** : 当代码被保存时自动编译文件；

3. **never**: 从不自动编译，即需编写者手动编译文档

```json
"latex-workshop.showContextMenu": true
```

启用上下文LaTeX菜单。此菜单默认状态下停用，即变量设置为**false**，因为它可以通过新的 LaTeX 标记使用（新的 LaTeX 标记能够编译文档，将在下文提及）。只需将此变量设置为**true**即可恢复菜单。即此命令设置是否将编译文档的选项出现在鼠标右键的菜单中。

```json
"latex-workshop.intellisense.package.enabled": true
```

设置为**true**，则该拓展能够从使用的宏包中自动提取命令和环境，从而补全正在编写的代码。

```json
"latex-workshop.message.error.show"  : false,
"latex-workshop.message.warning.show": false
```

这两个命令是设置当文档编译错误时是否弹出显示出错和警告的弹窗。因为这些错误和警告信息能够从终端中获取，且弹窗弹出比较烦人，故而笔者设置均设置为**false**。

```json
"latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOCFILE%"
            ]
        },
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOCFILE%"
            ]
        },
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-pdf",
                "-outdir=%OUTDIR%",
                "%DOCFILE%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        }
    ]
```

这些代码是定义在下文 recipes 编译链中被使用的编译命令，此处为默认配置，不需要进行更改。其中的`name`为这些命令的标签，用作下文 recipes 的引用；而`command`为在该拓展中的编译方式。

> [!NOTE]
> 可以更改的代码为，将编译方式: pdflatex 、 xelatex 和 latexmk 中的`%DOCFILE`更改为`%DOC`。`%DOCFILE`表明编译器访问没有扩展名的根文件名，而`%DOC`表明编译器访问的是没有扩展名的根文件完整路径。这就意味着，使用`%DOCFILE`可以将文件所在路径设置为中文，但笔者不建议这么做，因为毕竟涉及到代码，当其余编译器引用时该 tex 文件仍需要根文件完整路径，且需要为英文路径。笔者此处设置为`%DOCFILE`仅是因为之前使用 TeXstudio，导致路径已经是中文了。

```json
"latex-workshop.latex.recipes": [
        {
            "name": "XeLaTeX",
            "tools": [
                "xelatex"
            ]
        },
        {
            "name": "PDFLaTeX",
            "tools": [
                "pdflatex"
            ]
        },
        {
            "name": "BibTeX",
            "tools": [
                "bibtex"
            ]
        },
        {
            "name": "LaTeXmk",
            "tools": [
                "latexmk"
            ]
        },
        {
            "name": "xelatex -> bibtex -> xelatex*2",
            "tools": [
                "xelatex",
                "bibtex",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "pdflatex -> bibtex -> pdflatex*2",
            "tools": [
                "pdflatex",
                "bibtex",
                "pdflatex",
                "pdflatex"
            ]
        }
    ]
```

此串代码是对编译链进行定义，其中`name`是标签，也就是出现在工具栏中的链名称；`tool`是`name`标签所对应的编译顺序，其内部编译命令来自上文`latex-workshop.latex.recipes`中内容。

定义完成后，能够在 vscode 编译器中看到编译顺序

> [!PDFLaTeX 编译模式与 XeLaTeX 区别如下：]
> 
>  1. PDFLaTeX 使用的是TeX的标准字体，所以生成PDF时，会将所有的非 TeX 标准字体进行替换，其生成的 PDF 文件默认嵌入所有字体；而使用 XeLaTeX 编译，如果说论文中有很多图片或者其他元素没有嵌入字体的话，生成的 PDF 文件也会有些字体没有嵌入。     
>  2. XeLaTeX 对应的 XeTeX 对字体的支持更好，允许用户使用操作系统字体来代替 TeX 的标准字体，而且对非拉丁字体的支持更好。    
>  3. PDFLaTeX 进行编译的速度比 XeLaTeX 速度快。

 编译链的存在是为了更方便编译，因为如果涉及到 **.bib** 文件，就需要进行多次不同命令的转换编译，比较麻烦，而编译链就解决了这个问题。

```json
"latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.bbl",
        "*.blg",
        "*.idx",
        "*.ind",
        "*.lof",
        "*.lot",
        "*.out",
        "*.toc",
        "*.acn",
        "*.acr",
        "*.alg",
        "*.glg",
        "*.glo",
        "*.gls",
        "*.ist",
        "*.fls",
        "*.log",
        "*.fdb_latexmk"
    ]
```

这串命令则是设置编译完成后要清除掉的辅助文件类型，若无特殊需求，无需进行更改。

```json
"latex-workshop.latex.autoClean.run": "onFailed"
```

这条命令是设置什么时候对上文设置的辅助文件进行清除。其变量有：

1. **onBuilt** : 无论是否编译成功，都选择清除辅助文件；

2. **onFailed** : 当编译失败时，清除辅助文件；

3. **never** : 无论何时，都不清除辅助文件。

由于 tex 文档编译有时需要用到辅助文件，比如编译目录和编译参考文献时，如果使用`onBuilt`命令，则会导致编译不出完整结果甚至编译失败；

而有时候将 tex 文件修改后进行编译时，可能会导致 pdf 文件没有正常更新的情况，这个时候可能就是由于辅助文件没有进行及时更新的缘故，需要清除辅助文件了，而`never`命令做不到这一点；

故而笔者使用了`onFailed`，同时解决了上述两个问题。

```json
"latex-workshop.latex.recipe.default": "lastUsed"
```

该命令的作用为设置 vscode 编译 tex 文档时的默认编译链。有两个变量： 1. **first** : 使用`latex-workshop.latex.recipes`中的第一条编译链，故而您可以根据自己的需要更改编译链顺序； 2. **lastUsed** : 使用最近一次编译所用的编译链。

笔者选择使用**lastUsed**。

```json
"latex-workshop.view.pdf.internal.synctex.keybinding": "double-click"
```

用于反向同步（即从编译出的 pdf 文件指定位置跳转到 tex 文件中相应代码所在位置）的内部查看器的快捷键绑定。变量有两种：

1. **ctrl-click** ： 为默认选项，使用Ctrl/cmd+鼠标左键单击

2. **double-click** : 使用鼠标左键双击

此处笔者使用的为**double-click**。


## 设置快捷键

在键盘快捷方式中键入`recipe`，设置快捷键为 `ctrl+alt+q`，表示快捷编译

> [!NOTE]
> 编译成功时在vscode左下角有√的符号，否则为×

新开窗口显示编译好的pdf：`ctrl+alt+v`

正向同步测试（从代码定位到pdf页面对应位置）：选中代码所在行按`ctrl+alt+j`

反向同步测试：即上面配置的用鼠标左键双击

## sumatraPDF配置

```json
"latex-workshop.view.pdf.viewer": "external"
```

设置默认的pdf查看器，有三种变量参数：

1. **tab** : 使用 vscode 内置 pdf 查看器；

2. **browser** : 使用电脑默认浏览器进行 pdf 查看；

3. **external** : 使用外部 pdf 查看器查看。

此处选择 **external** 参数，使用外部查看器。

> [!NOTE]
> 此参数为下文进行pdf内部查看和外部查看进行切换的关键参数。

```json
"latex-workshop.view.pdf.ref.viewer":"auto"
```

设置PDF查看器用于在 **\ref** 命令上的[View on PDF]链接，此命令作用于 **\ref** 引用查看。有三个参数变量：

1. **auto** : 由编辑器根据情况自动设置；

2. **tabOrBrowser** : 使用vscode内置pdf查看器或使用电脑默认浏览器进行pdf查看；

3. **external** : 使用外部pdf查看器查看。

此处设置为**auto**。

```json
"latex-workshop.view.pdf.external.viewer.command": "F:/SumatraPDF/SumatraPDF.exe"// 注意修改路径
```

使用外部查看器时要执行的命令，设置外部查看器启动文件**SumatraPDF.exe**文件所在位置，此处需要您根据自身情况进行路径更改，正常情况下只需更改磁盘盘符即可。

**请注意**中间为 **" / "** 而不是**" \ "** ，不然会报错。

```json
"latex-workshop.view.pdf.external.viewer.args": [
        "%PDF%"
    ]
```

此代码是设置使用外部查看器时，`latex-workshop.view.pdf.external.view .command`的参数。`%PDF%`是用于生成PDF文件的绝对路径的占位符。

```json
"latex-workshop.view.pdf.external.synctex.command": "F:/SumatraPDF/SumatraPDF.exe" // 注意修改路径
```

此命令是将生成的辅助文件 **.synctex.gz** 转发到外部查看器时要执行的命令,设置其位置参数，您注意更改路径，此路径为 **SumatraPDF.exe** 文件路径。与上文相同。

```json
"latex-workshop.view.pdf.external.synctex.args": [
        "-forward-search",
        "%TEX%",
        "%LINE%",
        "-reuse-instance",
        "-inverse-search",
        "\"F:/Microsoft VS Code/Code.exe\" \"F:/Microsoft VS Code/resources/app/out/cli.js\" -r -g \"%f:%l\"", // 注意修改路径
        "%PDF%"
    ]
```

当 **.synctex.gz** 文件同步到外部查看器时`latex-workshop.view.pdf.external.synctex`的参数设置。`%LINE%`是行号，`%PDF%`是生成PDF文件的绝对路径的占位符，`%TEX%`是当触发syncTeX被触发时，扩展名为 **.tex** 的 LaTeX 文件路径。

## 总配置

```json
{
 //------------------------------LaTeX 配置----------------------------------
    // 设置是否自动编译
    "latex-workshop.latex.autoBuild.run":"never",
    //右键菜单
    "latex-workshop.showContextMenu":true,
    //从使用的包中自动补全命令和环境
    "latex-workshop.intellisense.package.enabled": true,
    //编译出错时设置是否弹出气泡设置
    "latex-workshop.message.error.show": false,
    "latex-workshop.message.warning.show": false,
    // 编译工具和命令
    "latex-workshop.latex.tools": [
        {
            "name": "xelatex",
            "command": "xelatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOCFILE%"
            ]
        },
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOCFILE%"
            ]
        },
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "-pdf",
                "-outdir=%OUTDIR%",
                "%DOCFILE%"
            ]
        },
        {
            "name": "bibtex",
            "command": "bibtex",
            "args": [
                "%DOCFILE%"
            ]
        }
    ],
    // 用于配置编译链
    "latex-workshop.latex.recipes": [
        {
            "name": "XeLaTeX",
            "tools": [
                "xelatex"
            ]
        },
        {
            "name": "PDFLaTeX",
            "tools": [
                "pdflatex"
            ]
        },
        {
            "name": "BibTeX",
            "tools": [
                "bibtex"
            ]
        },
        {
            "name": "LaTeXmk",
            "tools": [
                "latexmk"
            ]
        },
        {
            "name": "xelatex -> bibtex -> xelatex*2",
            "tools": [
                "xelatex",
                "bibtex",
                "xelatex",
                "xelatex"
            ]
        },
        {
            "name": "pdflatex -> bibtex -> pdflatex*2",
            "tools": [
                "pdflatex",
                "bibtex",
                "pdflatex",
                "pdflatex"
            ]
        }
    ],
    //文件清理。此属性必须是字符串数组
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.bbl",
        "*.blg",
        "*.idx",
        "*.ind",
        "*.lof",
        "*.lot",
        "*.out",
        "*.toc",
        "*.acn",
        "*.acr",
        "*.alg",
        "*.glg",
        "*.glo",
        "*.gls",
        "*.ist",
        "*.fls",
        "*.log",
        "*.fdb_latexmk"
    ],
    //设置为onFaild 在构建失败后清除辅助文件
    "latex-workshop.latex.autoClean.run": "onFailed",
    // 使用上次的recipe编译组合
    "latex-workshop.latex.recipe.default": "lastUsed",
    // 用于反向同步的内部查看器的键绑定。ctrl/cmd +点击(默认)或双击
    "latex-workshop.view.pdf.internal.synctex.keybinding": "double-click",



    //使用 SumatraPDF 预览编译好的PDF文件
    // 设置VScode内部查看生成的pdf文件
    "latex-workshop.view.pdf.viewer": "external",
    // PDF查看器用于在\ref上的[View on PDF]链接
    "latex-workshop.view.pdf.ref.viewer":"auto",
    // 使用外部查看器时要执行的命令。此功能不受官方支持。
    "latex-workshop.view.pdf.external.viewer.command": "F:/SumatraPDF/SumatraPDF.exe", // 注意修改路径
    // 使用外部查看器时，latex-workshop.view.pdf.external.view .command的参数。此功能不受官方支持。%PDF%是用于生成PDF文件的绝对路径的占位符。
    "latex-workshop.view.pdf.external.viewer.args": [
        "%PDF%"
    ],
    // 将synctex转发到外部查看器时要执行的命令。此功能不受官方支持。
    "latex-workshop.view.pdf.external.synctex.command": "F:/SumatraPDF/SumatraPDF.exe", // 注意修改路径
    // latex-workshop.view.pdf.external.synctex的参数。当同步到外部查看器时。%LINE%是行号，%PDF%是生成PDF文件的绝对路径的占位符，%TEX%是触发syncTeX的扩展名为.tex的LaTeX文件路径。
    "latex-workshop.view.pdf.external.synctex.args": [
        "-forward-search",
        "%TEX%",
        "%LINE%",
        "-reuse-instance",
        "-inverse-search",
        "\"F:/Microsoft VS Code/Code.exe\" \"F:/Microsoft VS Code/resources/app/out/cli.js\" -r -g \"%f:%l\"", // 注意修改路径
        "%PDF%"
    ]
}
```