
路径分配符 `**` 表示任意多层子目录，主要用于：PowerShell、git、Vscode 搜索、glob 模式（不包含 cmd）

在 Python 使用 glob 递归需引用 glob 模块，在 glob 函数中加入参数 `recursive=True` 激活 `**`，否则只会被当作普通文件名：

```python
import glob

files = glob.glob("C:/test/**/x.py",recursive=True)

for f in files:
	with f.open():
		pass
```

> [!NOTE]
> glob.glob 返回字符串列表，其中的字符串为 WindowsPath 对象

