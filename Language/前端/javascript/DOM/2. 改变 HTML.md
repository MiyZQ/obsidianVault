
## 改变 HTML 输出流

JS 中 document.write() 可用于直接向 HTML 输出流写内容，如：
```html
<body>
<script>
document.write(Date())
</script>
</body>
```

> [!ATTENTION]
> 不要再 DOM 加载完成之后使用 document.write()，这会覆盖文档

## 改变 HTML 内容

改变内容可使用 innerHTML 属性，如
```js
document.getElementById("demo").innerHTML = ...
```

## 改变 HTML 属性

修改 HTML 属性可使用下面语法：
```js
document.getElementById("demo").attribute = ...
```

如：
```html
<img id ="image" src="demo.gif">
<script>
document.getElementById("image").src = "demo2.png"
</script>
```