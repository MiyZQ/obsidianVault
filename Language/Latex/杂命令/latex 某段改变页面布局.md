
使用 **geometry** 包

`\geometry{}`在导言区使用，`\newgeometry{}`在正文区使用

### 结构

```latex
\newgeometry{right=20em,marginwidth=15em}
...
\restoregeometry
```

> [!NOTE]
> 上面两个命令会在调用位置插入 `\clearpage` 分页