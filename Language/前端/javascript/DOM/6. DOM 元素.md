
## appendChild() 方法

appendChild()用于添加 HTML 元素到尾部，如：
```html
<div id="div1">
<p id="p1">这是一个段落</p>
<p id="p2">这是另外一个段落</p>
</div>
 
<script>
// 创建<p>元素
var para = document.createElement("p"); 
// 为<p>元素创建新文本节点
var node = document.createTextNode("这是一个新的段落");
// 将文本节点添加到<p>元素中
para.appendChild(node);
// 在一个已存在的元素中添加<p>元素
var element = document.getElementById("div1");
element.appendChild(para);
</script>
```

## insertBefore() 方法

insertBefore() 相比 appendChild 可以添加元素到指定元素前一个位置：
```html
<div id="div1">
<p id="p1">这是一个段落</p>
<p id="p2">这是另外一个段落</p>
</div>
 
<script>
var para = document.createElement("p");
var node = document.createTextNode("这是一个新的段落");
para.appendChild(node);
 
var element = document.getElementById("div1");
var child = document.getElementById("p1");
element.insertBefore(para, child);
</script>
```

## 移除已存在的元素

要移除一个元素，需要知道该元素的父元素，可使用 removeChild() 方法：
```html
<div id="div1">
<p id="p1">这是一个段落</p>
<p id="p2">这是另外一个段落</p>
</div>
 
<script>
var parent = document.getElementById("div1");
var child = document.getElementById("p1");
parent.removeChild(child);
</script>
```

> [!NOTE]
> 如果只知道要删除的节点信息，可以如下使用：
> ```js
> var child = document.getElementById("p1");
> child.parentNode.removeChild(child);
> ```

## 替换 HTML 元素

可以使用 replaceChild（） 方法来替换 DOM 中的元素：
```html
<div id="div1">
<p id="p1">这是一个段落</p>
<p id="p2">这是另外一个段落</p>
</div>
 
<script>
var para = document.createElement("p");
var node = document.createTextNode("这是一个新的段落");
para.appendChild(node);
 
var parent = document.getElementById("div1");
var child = document.getElementById("p1");
parent.replaceChild(para, child);
</script>
```
同样的，replaceChild() 替换元素也需要知道元素的父节点，没有父节点会报错

> [!NOTE]
> 使用 replaceWith() 方法直接在旧元素上调用，浏览器内部自动找父节点，没有就不做任何事：
> ```js
> document.getElementById("p1").replaceWith(para);
> ```