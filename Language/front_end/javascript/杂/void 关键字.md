
> void 关键字指定要计算一个表达式但不返回值

语法：
```js
void func()
void(func())
javascript:void func()
javascript:void(func())
```

实例：
```html
<a href="javascript:void(alert('Warning'))">
点击
</a>
```

> [!NOTE] href="#" 与 href="javascript:void(0)" 的区别
> 
> `#` 包含一个位置信息，默认的锚是 `#top` 也就是网页的上端；
> `javascript:void(0)` 仅仅表示一个死链接
> 
> 页面很长时使用 `#` 来定位页面具体位置，格式为：`# + id`；
> 如果要定义一个死链接应使用 `javascript:void(0)`
> ```js
> <a href="javascript:void(0);">点击没有反应</a>
> <a href="#pos">点击定位到指定位置</a>
> <br>
> ...
> <br>
> <p id="pos">尾部定位点</p>
> ```

