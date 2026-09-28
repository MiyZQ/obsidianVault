
## 改变 HTML 样式

改变 HTML 元素的样式，使用这个语法：
```js
document.getElementById("demo").style.property = ...
```

如：
```html
<p id="p1">Hello World!</p> 
<p id="p2">Hello World!</p> 
<script> 
document.getElementById("p2").style.color="blue"; document.getElementById("p2").style.fontFamily="Arial"; document.getElementById("p2").style.fontSize="larger"; 
</script>
<p>以上段落通过脚本修改</p>
```

## 使用事件

通过事件的方式调用 JS 代码触发样式改变，如：
```html
<p id="p1">这是一个文本</p>
<input type="button" value="隐藏文本" onclick="document.getElementById('p1').style.visibility='hidden'" />
<input type="button" value="显示文本" onclick="document.getElementById('p1').style.visibility='visible'"/>
```